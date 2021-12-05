import 'dart:math';

class HydrothermalVentsMapping {
  final size = 1000;
  late List<List<int>> map;

  HydrothermalVentsMapping() {
    map = List.generate(size, (index) => List.generate(size, (index) => 0));
  }

  void addLine(Point<int> start, Point<int> end) {
    if (start.y == end.y) {
      return addHorizontalLine(start, end);
    } else if (start.x == end.x) {
      return addVerticalLine(start, end);
    }
  }

  void addHorizontalLine(Point<int> start, Point<int> end) {
    assert(start.y == end.y);
    final y = start.y;
    final startX = start.x <= end.x ? start.x : end.x;
    final endX = start.x <= end.x ? end.x : start.x;
    for (var s = startX; s <= endX; s++) {
      map[y][s] += 1;
    }
  }

  void addVerticalLine(Point<int> start, Point<int> end) {
    assert(start.x == end.x);
    final x = start.x;
    final startY = start.y <= end.y ? start.y : end.y;
    final endY = start.y <= end.y ? end.y : start.y;
    for (var s = startY; s <= endY; s++) {
      map[s][x] += 1;
    }
  }

  int get dangerousPointsCount => map.fold(
      0,
      (result, line) =>
          result +
          line.fold(
              0, (lineResult, value) => lineResult + (value >= 2 ? 1 : 0)));
}

int getDangerousAreasMapping(List<List<List<int>>> input) {
  final mapping = HydrothermalVentsMapping();
  for (var line in input) {
    final startPoint = Point(line[0][0], line[0][1]);
    final endPoint = Point(line[1][0], line[1][1]);
    mapping.addLine(startPoint, endPoint);
  }
  return mapping.dangerousPointsCount;
}
