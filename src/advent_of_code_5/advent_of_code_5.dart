import 'dart:math';

class HydrothermalVentsMapping {
  final int size;
  late List<List<int>> map;
  final bool excludeDiagonals;

  HydrothermalVentsMapping(
      {required this.size, this.excludeDiagonals = false}) {
    map = List.generate(size, (index) => List.generate(size, (index) => 0));
  }

  bool _isDiagonal(Point<int> start, Point<int> end) =>
      (end.x - start.x).abs() == (end.y - start.y).abs();

  void addLine(Point<int> start, Point<int> end) {
    if (start.y == end.y) {
      return _addHorizontalLine(start, end);
    } else if (start.x == end.x) {
      return _addVerticalLine(start, end);
    } else if (!excludeDiagonals && _isDiagonal(start, end)) {
      return _addDiagonalLine(start, end);
    }
  }

  void _addHorizontalLine(Point<int> start, Point<int> end) {
    assert(start.y == end.y);
    final y = start.y;
    final startX = start.x <= end.x ? start.x : end.x;
    final endX = start.x <= end.x ? end.x : start.x;
    for (var s = startX; s <= endX; s++) {
      map[y][s] += 1;
    }
  }

  void _addVerticalLine(Point<int> start, Point<int> end) {
    assert(start.x == end.x);
    final x = start.x;
    final startY = start.y <= end.y ? start.y : end.y;
    final endY = start.y <= end.y ? end.y : start.y;
    for (var s = startY; s <= endY; s++) {
      map[s][x] += 1;
    }
  }

  void _addDiagonalLine(Point<int> start, Point<int> end) {
    assert(_isDiagonal(start, end));
    var x = start.x;
    var y = start.y;
    while (x != end.x && y != end.y) {
      map[y][x] += 1;
      x += start.x < end.x ? 1 : -1;
      y += start.y < end.y ? 1 : -1;
    }
    map[end.y][end.x] += 1;
  }

  int get dangerousPointsCount => map.fold(
      0,
      (result, line) =>
          result +
          line.fold(
              0, (lineResult, value) => lineResult + (value >= 2 ? 1 : 0)));
}

int getDangerousAreasMapping(List<List<List<int>>> input,
    {required int size, bool excludeDiagonals = false}) {
  final mapping =
      HydrothermalVentsMapping(size: size, excludeDiagonals: excludeDiagonals);
  for (var line in input) {
    final startPoint = Point(line[0][0], line[0][1]);
    final endPoint = Point(line[1][0], line[1][1]);
    mapping.addLine(startPoint, endPoint);
  }
  return mapping.dangerousPointsCount;
}
