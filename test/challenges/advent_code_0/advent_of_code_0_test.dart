import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../../src/challenges/advent_of_code_0/advent_of_code_0.dart';
import '../../../src/utils/data_source.dart';
import '../../test_helpers.dart';

void main() {
  dayTestGroup(
    day: 0,
    solverBuilder: () => DailySolver0(
      day: 0,
      name: 'Day 0 - Tester Solver',
    ),
    partTestGroups: {
      1: PartTestGroup(
        (solver) {
          final solver0 = castSolverType<DailySolver0>(solver);
          test('some test from part 1', () {
            expect(solver0, isA<DailySolver0>());
          });
        },
        skipTypes: [DataSourceType.challenge],
      ),
      2: PartTestGroup(
        (solver) {
          final solver0 = castSolverType<DailySolver0>(solver);
          test('some test from part 2', () {
            expect(solver0, isA<DailySolver0>());
          });
        },
        skipTypes: [DataSourceType.challenge, DataSourceType.example],
      ),
    },
  );
}
