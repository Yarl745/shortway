import 'package:shortway/core/error/failure.dart';
import 'package:shortway/core/helper/type_aliases.dart';
import 'package:shortway/domain/entities/field.dart';
import 'package:shortway/domain/entities/shortest_path.dart';

/// Defines the interface for a repository managing pathfinding operations.
abstract class PathFinderRepository {
  Failure? findShortestPathFor({required Field field});
  FutureFailable<bool> checkFoundPathsIsCorrect({required String url});
  List<ShortestPath> getFoundShortestPaths();
  Failable<ShortestPath> getShortestPathBy({required String fieldId});
  void clearFoundShortestPaths();
}
