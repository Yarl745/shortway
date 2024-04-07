import 'package:shortway/domain/entities/coordinate.dart';

class FieldPoint {
  final Coordinate coord;
  final bool isBlocked;

  const FieldPoint({
    required this.coord,
    this.isBlocked = false,
  });

  @override
  String toString() {
    return 'FieldPoint{coord: $coord, isBlocked: $isBlocked}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldPoint &&
          runtimeType == other.runtimeType &&
          coord == other.coord &&
          isBlocked == other.isBlocked;

  @override
  int get hashCode => coord.hashCode ^ isBlocked.hashCode;
}
