import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../src/advent_of_code_5/advent_of_code_5.dart';

void main() {
  group('getDangerousAreasMapping', () {
    test(
        'should return the number of points where at least two lines overlap counnting horizontals & verticals',
        () {
      const input = [
        [
          [0, 9],
          [5, 9]
        ],
        [
          [8, 0],
          [0, 8]
        ],
        [
          [9, 4],
          [3, 4]
        ],
        [
          [2, 2],
          [2, 1]
        ],
        [
          [7, 0],
          [7, 4]
        ],
        [
          [6, 4],
          [2, 0]
        ],
        [
          [0, 9],
          [2, 9]
        ],
        [
          [3, 4],
          [1, 4]
        ],
        [
          [0, 0],
          [8, 8]
        ],
        [
          [5, 5],
          [8, 2]
        ],
      ];
      expect(
          getDangerousAreasMapping(input, size: 10, excludeDiagonals: true), 5);
    });

    test(
        'should return the number of points where at least two lines overlap counting horizontals, verticals & diagonals',
        () {
      const input = [
        [
          [0, 9],
          [5, 9]
        ],
        [
          [8, 0],
          [0, 8]
        ],
        [
          [9, 4],
          [3, 4]
        ],
        [
          [2, 2],
          [2, 1]
        ],
        [
          [7, 0],
          [7, 4]
        ],
        [
          [6, 4],
          [2, 0]
        ],
        [
          [0, 9],
          [2, 9]
        ],
        [
          [3, 4],
          [1, 4]
        ],
        [
          [0, 0],
          [8, 8]
        ],
        [
          [5, 5],
          [8, 2]
        ],
      ];
      expect(getDangerousAreasMapping(input, size: 10), 12);
    });
  });
}
