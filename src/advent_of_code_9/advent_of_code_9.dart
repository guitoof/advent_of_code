import 'dart:math';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

typedef Input = List<List<int>>;

int sumMinHeights(Input input) {
  final bassins = findAllBassins(input);
  return bassins.fold(0, (sum, bassin) => sum + 1 + bassin.height);
}

List<Bassin> findAllBassins(Input input) {
  List<Bassin> bassins = [];
  for (var y = 0; y < input.length; y++) {
    for (var x = 0; x < input[y].length; x++) {
      if ((y < input.length - 1 ? input[y][x] < input[y + 1][x] : true) &&
          (y > 0 ? input[y][x] < input[y - 1][x] : true) &&
          (x < input[y].length - 1 ? input[y][x] < input[y][x + 1] : true) &&
          (x > 0 ? input[y][x] < input[y][x - 1] : true)) {
        bassins.add(Bassin(center: Point(x, y), height: input[y][x]));
      }
    }
  }
  for (var bassin in bassins) {
    bassin.points = findBassinNeighbours(point: bassin.center, input: input);
    bassin.points = bassin.points.distinct();
  }
  return bassins;
}

List<Point<int>> findBassinNeighbours(
    {required Point<int> point, required List<List<int>> input}) {
  List<Point<int>> bassinNeighbours = [];
  if (point.y < input.length - 1 &&
      input[point.y + 1][point.x] < 9 &&
      input[point.y][point.x] < input[point.y + 1][point.x]) {
    bassinNeighbours.add(Point<int>(point.x, point.y + 1));
  }
  if (point.y > 0 &&
      input[point.y - 1][point.x] < 9 &&
      input[point.y][point.x] < input[point.y - 1][point.x]) {
    bassinNeighbours.add(Point<int>(point.x, point.y - 1));
  }
  if (point.x < input[point.y].length - 1 &&
      input[point.y][point.x + 1] < 9 &&
      input[point.y][point.x] < input[point.y][point.x + 1]) {
    bassinNeighbours.add(Point<int>(point.x + 1, point.y));
  }
  if (point.x > 0 &&
      input[point.y][point.x - 1] < 9 &&
      input[point.y][point.x] < input[point.y][point.x - 1]) {
    bassinNeighbours.add(Point<int>(point.x - 1, point.y));
  }

  return [
    ...bassinNeighbours,
    ...bassinNeighbours.fold(
      [],
      (neighbours, newPoint) => [
        point,
        ...neighbours,
        ...findBassinNeighbours(point: newPoint, input: input).toList()
      ],
    )
  ];
}

int getLargestBassinArea(Input input) {
  return findAllBassins(input)
      .sortedReversed((a, b) => a.size - b.size)
      .sublist(0, 3)
      .fold<int>(1, (product, bassin) => product * bassin.size);
}

class Bassin {
  final Point<int> center;
  final int height;
  List<Point<int>> points = [];

  Bassin({required this.center, required this.height});

  Bassin.fromRawData(
      {required this.center, required this.height, required this.points});

  int get size => points.length;

  @override
  String toString() => '''
    {
      center: $center,
      height: $height,
      size: $size,
    }
  ''';
}
