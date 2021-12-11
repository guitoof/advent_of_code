import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../src/advent_of_code_11/advent_of_code_11.dart';

void main() {
  group('countOctopusFlashes', () {
    var input = <List<int>>[
      [5, 4, 8, 3, 1, 4, 3, 2, 2, 3],
      [2, 7, 4, 5, 8, 5, 4, 7, 1, 1],
      [5, 2, 6, 4, 5, 5, 6, 1, 7, 3],
      [6, 1, 4, 1, 3, 3, 6, 1, 4, 6],
      [6, 3, 5, 7, 3, 8, 5, 4, 7, 8],
      [4, 1, 6, 7, 5, 2, 4, 6, 4, 5],
      [2, 1, 7, 6, 8, 4, 1, 7, 2, 1],
      [6, 8, 8, 2, 8, 8, 1, 1, 3, 4],
      [4, 8, 4, 6, 8, 4, 8, 5, 5, 4],
      [5, 2, 8, 3, 7, 5, 1, 5, 2, 6],
    ];
    test('should return the number of Flashes after 1 steps', () {
      expect(countOctopusFlashes(input, steps: 1), 0);
    });
    test('should return the number of Flashes after 2 steps', () {
      expect(countOctopusFlashes(input, steps: 2), 35);
    });
    test('should return the number of Flashes after 100 steps', () {
      expect(countOctopusFlashes(input, steps: 100), 1656);
    });
  });
}
