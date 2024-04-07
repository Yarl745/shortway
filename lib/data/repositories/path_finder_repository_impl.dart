import 'dart:collection';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:shortway/core/error/error_handler.dart';
import 'package:shortway/core/error/exceptions.dart';
import 'package:shortway/core/error/failure.dart';
import 'package:shortway/core/helper/type_aliases.dart';
import 'package:shortway/data/datasources/api_remote_data_source.dart';
import 'package:shortway/domain/entities/coordinate.dart';
import 'package:shortway/domain/entities/field.dart';
import 'package:shortway/domain/entities/field_point.dart';
import 'package:shortway/domain/entities/shortest_path.dart';
import 'package:shortway/domain/repositories/path_finder_repository.dart';

class PathFinderRepositoryImpl implements PathFinderRepository {
  final ApiRemoteDataSource _apiRemoteDataSource;

  final List<ShortestPath> _shortestPaths = [];

  PathFinderRepositoryImpl({
    required ApiRemoteDataSource apiRemoteDataSource,
  }) : _apiRemoteDataSource = apiRemoteDataSource;

  @override
  Failure? findShortestPathFor({required Field field}) {
    try {
      final finder = _PathFinder(
        fieldId: field.id,
        start: field.start.coord,
        end: field.end.coord,
        fieldPoints: field.fieldPoints,
      );
      final path = finder._findShortestPaths();
      _shortestPaths.add(path);
    } catch (error) {
      final failure = handleError(error);

      return failure;
    }
    return null;
  }

  @override
  FutureFailable<bool> checkFoundPathsIsCorrect({required String url}) async {
    try {
      final correct = await _apiRemoteDataSource.checkShortestPaths(
        paths: _shortestPaths,
        url: url,
      );

      return right(correct);
    } catch (error) {
      final failure = handleError(error);

      return left(failure);
    }
  }

  @override
  List<ShortestPath> getFoundShortestPaths() {
    return _shortestPaths;
  }

  @override
  void clearFoundShortestPaths() {
    _shortestPaths.clear();
  }

  @override
  Failable<ShortestPath> getShortestPathBy({required String fieldId}) {
    try {
      try {
        final field = _shortestPaths.firstWhere(
          (path) => path.fieldId == fieldId,
        );

        return right(field);
      } on StateError {
        throw NoPathException();
      }
    } catch (error) {
      final failure = handleError(error);

      return left(failure);
    }
  }
}

class _PathFinder {
  static const _directions = [
    Coordinate(0, 1),
    Coordinate(1, 0),
    Coordinate(0, -1),
    Coordinate(-1, 0),
    Coordinate(-1, -1),
    Coordinate(-1, 1),
    Coordinate(1, -1),
    Coordinate(1, 1),
  ];

  final String _fieldId;
  final List<List<FieldPoint>> _fieldPoints;
  final Coordinate _start;
  final Coordinate _end;

  const _PathFinder({
    required String fieldId,
    required List<List<FieldPoint>> fieldPoints,
    required Coordinate start,
    required Coordinate end,
  })  : _fieldId = fieldId,
        _fieldPoints = fieldPoints,
        _start = start,
        _end = end;

  ShortestPath _findShortestPaths() {
    if (!_isWalkable(_start) || !_isWalkable(_end)) {
      throw NoPathException();
    }

    final Queue<List<Coordinate>> pathVariants = Queue();
    pathVariants.add([_start]);
    final Set<Coordinate> visitedPoints = {_start};

    while (pathVariants.isNotEmpty) {
      final pathVariant = pathVariants.removeFirst();
      final currentPoint = pathVariant.last;

      if (currentPoint == _end) {
        final hasMorePaths = _hasMoreShortestPaths(shortestSteps: pathVariant);
        return ShortestPath(
          fieldId: _fieldId,
          steps: pathVariant,
          hasVariants: hasMorePaths,
        );
      }

      for (final Coordinate neighbor in _getNeighbors(currentPoint)) {
        if (visitedPoints.contains(neighbor)) continue;

        visitedPoints.add(neighbor);
        pathVariants.add([...pathVariant, neighbor]);
      }
    }

    throw NoPathException();
  }

  bool _hasMoreShortestPaths({required List<Coordinate> shortestSteps}) {
    final maxLength = shortestSteps.length;

    for (var i = 0; i < maxLength - 2; i++) {
      final currentStep = shortestSteps[i];
      final nextStep = shortestSteps[min(i + 1, maxLength - 1)];
      final followingStep = shortestSteps[min(i + 2, maxLength - 1)];

      for (final alternateStep in _getNeighbors(currentStep)) {
        if (alternateStep == nextStep) continue;

        if (_getNeighbors(alternateStep).contains(followingStep)) {
          return true;
        }
      }
    }

    return false;
  }

  List<Coordinate> _getNeighbors(Coordinate coord) {
    final List<Coordinate> neighbors = [];

    for (final direction in _directions) {
      final next = Coordinate(
        coord.x + direction.x,
        coord.y + direction.y,
      );
      if (_isWalkable(next)) {
        neighbors.add(next);
      }
    }

    return neighbors;
  }

  bool _isWalkable(Coordinate coord) {
    return coord.x >= 0 &&
        coord.x < _fieldPoints.first.length &&
        coord.y >= 0 &&
        coord.y < _fieldPoints.length &&
        _fieldPoints[coord.x][coord.y].isBlocked != true;
  }
}
