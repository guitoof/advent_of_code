import 'package:test/scaffolding.dart';
import '../../../src/challenges/advent_of_code_0/advent_of_code_0.dart';
import '../../test_helpers.dart';

void main() {
  testSuite<DailySolver0>(
      day: 0,
      solverBuilder: () => DailySolver0(
            day: 0,
            name: 'Day 0 - Tester Solver',
          ),
      part1TestBlock: (part1Solver) {
        group('[someMethodForPart1]', () {
          test('should...', () async {
            /// Expect things here
          });
        });
      },
      part2TestBlock: (part2Solver) {
        group('[someMethodForPart2]', () {
          test('should...', () async {
            /// Expect things here
          });
        });
      });
}
