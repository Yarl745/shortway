import 'package:shortway/domain/entities/coordinate.dart';

class ShortestPath {
  final String fieldId;
  final List<Coordinate> steps;
  final bool hasVariants;

  String get path => steps.map((coord) => "(${coord.x},${coord.y})").join("->");

  const ShortestPath({
    required this.fieldId,
    required this.steps,
    required this.hasVariants,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShortestPath &&
          runtimeType == other.runtimeType &&
          fieldId == other.fieldId &&
          steps == other.steps &&
          path == other.path;

  @override
  int get hashCode => fieldId.hashCode ^ steps.hashCode ^ path.hashCode;

  @override
  String toString() {
    return 'ShortestPath{'
        'fieldId: $fieldId, steps: $steps, '
        'path: $path, hasVariants: $hasVariants}';
  }
}
