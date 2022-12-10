import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../advent_of_code_4.dart';
import '../../../utils/data_source.dart';
import '../../../utils/test/test_helpers.dart';

void main() {
  dayTestGroup(
    'Day 4',
    solverBuilder: () => DailySolver4(day: 4),
    partTestGroups: {
      1: PartTestGroup(
        (solver, type) {
          final solver4 = castSolverType<DailySolver4>(solver);
          testGroupWithExpectedDataByType(
            '[countFullyContainedPairs]',
            expectedDataMap: {
              DataSourceType.example: 2,
            },
            type: type,
            body: ({expectedData}) {
              test('return the count of fully contained pairs', () async {
                expect(
                    await solver4.solve(part: 1, forType: type), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
      2: PartTestGroup(
        (solver, type) {
          final solver4 = castSolverType<DailySolver4>(solver);
          testGroupWithExpectedDataByType(
            '[someMethod2] relevant to part 2',
            expectedDataMap: {
              DataSourceType.example: 'Expected Data for Example',
            },
            type: type,
            body: ({expectedData}) {
              test('test some behavior of [someMethod2]', () async {
                expect(solver4, isA<DailySolver4>());
                // Use [expectedData] to test the behavior of [someMethod]
                // expect(solver4.someMethod2(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge, DataSourceType.example],
      ),
    },
  );
}
