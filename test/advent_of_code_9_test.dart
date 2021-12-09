import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../src/advent_of_code_9/advent_of_code_9.dart';

void main() {
  group('sumMinHeights', () {
    test('should return the sum of minimal heights', () {
      const input = <List<int>>[
        [2, 1, 9, 9, 9, 4, 3, 2, 1, 0],
        [3, 9, 8, 7, 8, 9, 4, 9, 2, 1],
        [9, 8, 5, 6, 7, 8, 9, 8, 9, 2],
        [8, 7, 6, 7, 8, 9, 6, 7, 8, 9],
        [9, 8, 9, 9, 9, 6, 5, 6, 7, 8],
      ];
      expect(sumMinHeights(input), 15);
    });
  });
}
