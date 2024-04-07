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

/// Implementation of the PathFinderRepository for managing shortest path finding operations.
class PathFinderRepositoryImpl implements PathFinderRepository {
  final ApiRemoteDataSource _apiRemoteDataSource;

  final List<ShortestPath> _shortestPaths = [];

  PathFinderRepositoryImpl({
    required ApiRemoteDataSource apiRemoteDataSource,
  }) : _apiRemoteDataSource = apiRemoteDataSource;

  /// Finds the shortest path for a given field and caches it.
  ///
  /// This method leverages a custom pathfinding algorithm to find the shortest path
  /// within a field. It updates the cache with the found path.
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

  /// Verifies the correctness of all found shortest paths with a backend API.
  ///
  /// This method sends the cached shortest paths to a remote API to verify their correctness.
  /// It returns a Future encapsulating a boolean result or a Failure in case of an error.
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

  /// Retrieves all cached shortest paths.
  @override
  List<ShortestPath> getFoundShortestPaths() {
    return _shortestPaths;
  }

  /// Clears the cache of found shortest paths.
  @override
  void clearFoundShortestPaths() {
    _shortestPaths.clear();
  }

  /// Retrieves a specific shortest path by the field ID from the cache.
  ///
  /// This method searches the cache for a shortest path associated with a given field ID.
  /// If found, it returns the path; otherwise, it returns a Failure.
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

/// Internal class implementing the pathfinding algorithm.
///
/// This class encapsulates the logic for finding the shortest path between two points
/// in a field. It considers the field's layout and any obstacles that may block the path.
class _PathFinder {
  /// Directions for moving to adjacent points, including diagonals.
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

  /// Finds and returns the shortest path between the start and end points.
  ///
  /// This method implements the pathfinding algorithm, taking into account the layout
  /// of the field and obstacles. It returns the shortest path as a ShortestPath entity.
  ShortestPath _findShortestPaths() {
    // Check if start and end points are walkable.
    if (!_isWalkable(_start) || !_isWalkable(_end)) {
      throw NoPathException();
    }

    // Initialize a queue to keep track of path variants.
    final Queue<List<Coordinate>> pathVariants = Queue<List<Coordinate>>();
    // Add the starting point as the initial path.
    pathVariants.add([_start]);
    // Set to keep track of visited points to avoid revisiting.
    final Set<Coordinate> visitedPoints = {_start};

    while (pathVariants.isNotEmpty) {
      final pathVariant = pathVariants.removeFirst();
      final currentPoint = pathVariant.last;

      // If the current point is the end point, construct and return the shortest path.
      if (currentPoint == _end) {
        // Check if there are multiple shortest paths.
        final hasMorePaths = _hasMoreShortestPaths(shortestSteps: pathVariant);
        return ShortestPath(
          fieldId: _fieldId,
          steps: pathVariant,
          hasVariants: hasMorePaths,
        );
      }

      // For each neighbor of the current point,
      // if it hasn't been visited, add it to the path variants.
      for (final Coordinate neighbor in _getNeighbors(currentPoint)) {
        if (visitedPoints.contains(neighbor)) continue;

        visitedPoints.add(neighbor);
        pathVariants.add([...pathVariant, neighbor]);
      }
    }

    // If no path to the end point was found, throw an exception.
    throw NoPathException();
  }

  /// Determines if there are multiple shortest paths available.
  bool _hasMoreShortestPaths({required List<Coordinate> shortestSteps}) {
    final maxLength = shortestSteps.length;

    for (var i = 0; i < maxLength - 2; i++) {
      final currentStep = shortestSteps[i];
      final nextStep = shortestSteps[min(i + 1, maxLength - 1)];
      final followingStep = shortestSteps[min(i + 2, maxLength - 1)];

      // Check for alternative paths diverging from the current step and leading to the following step.
      for (final alternateStep in _getNeighbors(currentStep)) {
        if (alternateStep == nextStep) continue;

        // If an alternate path from this detour leads directly to a point further in the original path,
        // it indicates the existence of a variant to the shortest path.
        if (_getNeighbors(alternateStep).contains(followingStep)) {
          return true;
        }
      }
    }

    // If no alternate paths are found that meet the criteria, return false.
    return false;
  }

  /// Returns a list of walkable neighbors for a given coordinate.
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

  /// Determines if a given coordinate is walkable, considering field boundaries and obstacles.
  bool _isWalkable(Coordinate coord) {
    return coord.x >= 0 &&
        coord.x < _fieldPoints.first.length &&
        coord.y >= 0 &&
        coord.y < _fieldPoints.length &&
        _fieldPoints[coord.x][coord.y].isBlocked != true;
  }
}
