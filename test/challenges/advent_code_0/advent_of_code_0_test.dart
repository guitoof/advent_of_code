import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../../src/challenges/advent_of_code_0/advent_of_code_0.dart';
import '../../../src/utils/data_source.dart';
import '../../test_helpers.dart';

void main() {
  dayTestGroup(
    'Day 0',
    solverBuilder: () => DailySolver0(day: 0),
    partTestGroups: {
      1: PartTestGroup(
        (solver, type) {
          final solver0 = castSolverType<DailySolver0>(solver);
          testGroupWithExpectedDataByType(
            '[someMethod1] relevant to part 1',
            expectedDataMap: {
              DataSourceType.example: 'Expected Data for Example',
              // Challenge case will be skipped
              // if [DataSourceType.challenge] is missing (null)
            },
            type: type,
            body: ({expectedData}) {
              test('test some behavior of [someMethod1]', () async {
                expect(solver0, isA<DailySolver0>());
                // Use [expectedData] to test the behavior of [someMethod]
                // expect(solver0.someMethod1(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
      2: PartTestGroup(
        (solver, type) {
          final solver0 = castSolverType<DailySolver0>(solver);
          testGroupWithExpectedDataByType(
            '[someMethod2] relevant to part 2',
            expectedDataMap: {
              DataSourceType.example: 'Expected Data for Example',
              // Challenge case will be skipped
              // if [DataSourceType.challenge] is missing (null)
            },
            type: type,
            body: ({expectedData}) {
              test('test some behavior of [someMethod2]', () async {
                expect(solver0, isA<DailySolver0>());
                // Use [expectedData] to test the behavior of [someMethod]
                // expect(solver0.someMethod2(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge, DataSourceType.example],
      ),
    },
  );
}
