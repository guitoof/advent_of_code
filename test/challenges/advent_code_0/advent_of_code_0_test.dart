import 'package:test/scaffolding.dart';
import '../../../src/challenges/advent_of_code_0/advent_of_code_0.dart';
import '../../test_helpers.dart';

void main() {
  testSuite(
      day: 0,
      solverBuilder: () => DailySolver0(
            day: 0,
            name: 'Day 0 - Tester Solver',
          ),
      part1TestBlock: () {
        group('[someMethodForPart1]', () {
          test('should...', () async {
            /// Expect things here
          });
        });
      },
      part2TestBlock: () {
        group('[someMethodForPart2]', () {
          test('should...', () async {
            /// Expect things here
          });
        });
      });
}
