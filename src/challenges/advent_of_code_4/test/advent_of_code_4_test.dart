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
            '[countOverlappingPairs]',
            expectedDataMap: {
              DataSourceType.example: 4,
            },
            type: type,
            body: ({expectedData}) {
              test('should return the count of overlapping pairs', () async {
                expect(solver4.countOverlappingPairs, expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
    },
  );
}
