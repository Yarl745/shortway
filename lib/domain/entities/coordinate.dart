class Coordinate {
  final int x;
  final int y;

  const Coordinate(this.x, this.y);

  @override
  String toString() {
    return 'Coordinate{x: $x, y: $y}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coordinate &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
