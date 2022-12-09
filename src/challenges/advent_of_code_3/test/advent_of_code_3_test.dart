import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../advent_of_code_3.dart';
import '../../../utils/data_source.dart';
import '../../../utils/test/test_helpers.dart';

void main() {
  dayTestGroup(
    'Day 3',
    solverBuilder: () => DailySolver3(day: 3),
    partTestGroups: {
      1: PartTestGroup(
        (solver, type) {
          final solver3 = castSolverType<DailySolver3>(solver);
          testGroupWithExpectedDataByType(
            '[getAllDuplicates]',
            expectedDataMap: {
              DataSourceType.example: [
                ['p'],
                ['L'],
                ['P'],
                ['v'],
                ['t'],
                ['s'],
              ],
            },
            type: type,
            body: ({expectedData}) {
              test('should return the list of duplicates for all rucksacks',
                  () async {
                expect(solver3.getAllDuplicates(), expectedData);
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[solve]',
            expectedDataMap: {
              DataSourceType.example: 157,
              DataSourceType.challenge: 8298,
            },
            type: type,
            body: ({expectedData}) {
              test(
                  '''should return the sum of the priority of each item appearing in both compartments''',
                  () async {
                expect(
                    await solver3.solve(part: 1, forType: type), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.example],
      ),
      2: PartTestGroup(
        (solver, type) {
          final solver3 = castSolverType<DailySolver3>(solver);
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
                expect(solver3, isA<DailySolver3>());
                // Use [expectedData] to test the behavior of [someMethod]
                // expect(solver3.someMethod2(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge, DataSourceType.example],
      ),
    },
  );
}
