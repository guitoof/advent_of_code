import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../advent_of_code_8.dart';
import '../../../utils/data_source.dart';
import '../../../utils/test/test_helpers.dart';

void main() {
  dayTestGroup(
    'Day 8',
    solverBuilder: ({required part}) => DailySolver8(day: 8, part: part),
    partTestGroups: {
      1: PartTestGroup(
        (solver, type) {
          final solver8 = castSolverType<DailySolver8>(solver);
          testGroupWithExpectedDataByType(
            '[countVisibleTrees]',
            expectedDataMap: {
              DataSourceType.example: 21, // 16 + 5
            },
            type: type,
            body: ({expectedData}) {
              test('test some behavior of [someMethod1]', () async {
                expect(solver8.countVisibleTrees(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
      2: PartTestGroup(
        (solver, type) {
          final solver8 = castSolverType<DailySolver8>(solver);
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
                expect(solver8, isA<DailySolver8>());
                // Use [expectedData] to test the behavior of [someMethod]
                // expect(solver8.someMethod2(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge, DataSourceType.example],
      ),
    },
  );
}
