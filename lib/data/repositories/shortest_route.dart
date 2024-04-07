// import 'dart:collection';
//
// void main() {
//   // final json = {
//   //   "id": "7d785c38-cd54-4a98-ab57-4450a646c1",
//   //   "field": [
//   //     "XXX.",
//   //     "X.X.",
//   //     "X..X",
//   //     "..XX",
//   //   ],
//   //   "start": {"x": 2, "y": 1},
//   //   "end": {"x": 0, "y": 2}
//   // };
//   // final model = FieldModel.fromJson(json);
//   //
//   // print(model.toEntity().field);
// }
//
// void mainn() {
//   // Example usage:
//   List<String> field = [
//     "XXX.",
//     "X.X.",
//     "X..X",
//     "..XX",
//   ];
//   CoordinateTest start = const CoordinateTest(0, 3);
//   CoordinateTest end = const CoordinateTest(2, 2);
//   GridPathfinder pathfinder = GridPathfinder(field, start, end);
//
//   try {
//     List<List<CoordinateTest>> path = pathfinder.findPath();
//     print("Path found: $path");
//   } catch (e) {
//     print("Error: ${e.toString()}");
//   }
// }
//
// class CoordinateTest {
//   final int x;
//   final int y;
//
//   const CoordinateTest(this.x, this.y);
//
//   @override
//   String toString() => '($x, $y)';
//
//   @override
//   bool operator ==(Object other) =>
//       other is CoordinateTest && other.x == x && other.y == y;
//
//   @override
//   int get hashCode => x.hashCode ^ y.hashCode;
// }
//
// class GridPathfinder {
//   static const _directions = [
//     CoordinateTest(0, 1),
//     CoordinateTest(1, 0),
//     CoordinateTest(0, -1),
//     CoordinateTest(-1, 0),
//     CoordinateTest(-1, -1),
//     CoordinateTest(-1, 1),
//     CoordinateTest(1, -1),
//     CoordinateTest(1, 1),
//   ];
//
//   List<String> grid;
//   CoordinateTest start;
//   CoordinateTest end;
//
//   GridPathfinder(this.grid, this.start, this.end);
//
//   List<List<CoordinateTest>> findPath() {
//     if (!isWalkable(end) || !isWalkable(start)) {
//       throw Exception("Start or end position is not walkable.");
//     }
//
//     Queue<List<CoordinateTest>> routeVariants = Queue();
//     routeVariants.add([start]);
//     Set<CoordinateTest> visitedPoints = {start};
//     List<List<CoordinateTest>> shortestRoutes = [];
//
//     while (routeVariants.isNotEmpty) {
//       final routeVariant = routeVariants.removeFirst();
//       final current = routeVariant.last;
//
//       print("current routeVariant: $routeVariant}");
//
//       if (shortestRoutes.isNotEmpty &&
//           routeVariant.length > shortestRoutes.first.length) {
//         print("routeVariants: $routeVariants}");
//         return shortestRoutes;
//       }
//
//       if (current == end) {
//         shortestRoutes.add(routeVariant);
//       }
//
//       for (CoordinateTest neighbor in _getNeighbors(current)) {
//         if (visitedPoints.contains(neighbor)) continue;
//
//         visitedPoints.add(neighbor);
//         routeVariants.add([...routeVariant, neighbor]);
//       }
//     }
//
//     throw Exception("No path found.");
//   }
// }
