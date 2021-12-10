import 'dart:math';

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../src/advent_of_code_9/advent_of_code_9.dart';

void main() {
  const input = <List<int>>[
    [2, 1, 9, 9, 9, 4, 3, 2, 1, 0],
    [3, 9, 8, 7, 8, 9, 4, 9, 2, 1],
    [9, 8, 5, 6, 7, 8, 9, 8, 9, 2],
    [8, 7, 6, 7, 8, 9, 6, 7, 8, 9],
    [9, 8, 9, 9, 9, 6, 5, 6, 7, 8],
  ];
  group('sumMinHeights', () {
    test('should return the sum of minimal heights', () {
      expect(sumMinHeights(input), 15);
    });
  });

  group('findBassinNeighbours', () {
    test('should return all bassins', () {
      expect(
          findAllBassins(input).toString(),
          equals(
            [
              Bassin.fromRawData(
                center: Point(1, 0),
                height: 1,
                points: [Point(0, 0), Point(1, 0), Point(0, 1)],
              ),
              Bassin.fromRawData(
                center: Point(9, 0),
                height: 0,
                points: [
                  Point(9, 0),
                  Point(8, 0),
                  Point(7, 0),
                  Point(6, 0),
                  Point(5, 0),
                  Point(9, 1),
                  Point(8, 1),
                  Point(6, 1),
                  Point(9, 2),
                ],
              ),
              Bassin.fromRawData(
                center: Point(2, 2),
                height: 5,
                points: [
                  Point(2, 1),
                  Point(3, 1),
                  Point(4, 1),
                  Point(1, 2),
                  Point(2, 2),
                  Point(3, 2),
                  Point(4, 2),
                  Point(5, 2),
                  Point(0, 3),
                  Point(1, 3),
                  Point(2, 3),
                  Point(3, 3),
                  Point(4, 3),
                  Point(1, 4),
                ],
              ),
              Bassin.fromRawData(
                center: Point(6, 4),
                height: 5,
                points: [
                  Point(7, 2),
                  Point(6, 3),
                  Point(7, 3),
                  Point(8, 3),
                  Point(5, 4),
                  Point(6, 4),
                  Point(7, 4),
                  Point(8, 4),
                  Point(9, 4),
                ],
              ),
            ].toString(),
          ));
    });
  });

  group('getLargestBassinArea', () {
    test('should return the multiplication of the size of the 3 largest areas',
        () {
      expect(getLargestBassinArea(input), 1134);
    });
  });
}
