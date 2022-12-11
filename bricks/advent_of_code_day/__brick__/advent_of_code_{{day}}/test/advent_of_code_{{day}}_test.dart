import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../advent_of_code_{{day}}.dart';
import '../../../utils/data_source.dart';
import '../../../utils/test/test_helpers.dart';

void main() {
  dayTestGroup(
    'Day {{day}}',
    solverBuilder: (required part) => DailySolver{{day}}(day: {{day}}, part: part),
    partTestGroups: {
      1: PartTestGroup(
        (solver, type) {
          final solver{{day}} = castSolverType<DailySolver{{day}}>(solver);
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
                expect(solver{{day}}, isA<DailySolver{{day}}>());
                // Use [expectedData] to test the behavior of [someMethod]
                // expect(solver{{day}}.someMethod1(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
      2: PartTestGroup(
        (solver, type) {
          final solver{{day}} = castSolverType<DailySolver{{day}}>(solver);
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
                expect(solver{{day}}, isA<DailySolver{{day}}>());
                // Use [expectedData] to test the behavior of [someMethod]
                // expect(solver{{day}}.someMethod2(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge, DataSourceType.example],
      ),
    },
  );
}
