import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../../src/challenges/advent_of_code_2/advent_of_code_2.dart';
import '../../../src/utils/data_source.dart';
import '../../test_helpers.dart';

void main() {
  dayTestGroup(
    'Day 2',
    solverBuilder: () => DailySolver2(day: 2),
    partTestGroups: {
      1: PartTestGroup(
        (solver, type) {
          final solver2 = castSolverType<DailySolver2>(solver);
          testGroupWithExpectedDataByType(
            '[getRockPaperScissorsScore]',
            expectedDataMap: {
              DataSourceType.example: 15,
              DataSourceType.challenge: 13484,
            },
            type: type,
            body: ({expectedData}) {
              test('should return the score', () async {
                expect(solver2.getRockPaperScissorsScore(), expectedData);
              });
            },
          );
        },
        skipTypes: [],
      ),
      2: PartTestGroup(
        (solver, type) {
          //final solver2 = castSolverType<DailySolver2>(solver);
          // testGroupWithExpectedDataByType(
          //   '[someMethod2] relevant to part 2',
          //   expectedDataMap: {
          //     DataSourceType.example: 'Expected Data for Example',
          //     // Challenge case will be skipped
          //     // if [DataSourceType.challenge] is missing (null)
          //   },
          //   type: type,
          //   body: ({expectedData}) {
          //     test('test some behavior of [someMethod2]', () async {
          //       expect(solver2, isA<DailySolver2>());
          //       // Use [expectedData] to test the behavior of [someMethod]
          //       // expect(solver2.someMethod2(), expectedData);
          //     });
          //   },
          // );
        },
        skipTypes: [DataSourceType.challenge, DataSourceType.example],
      ),
    },
  );
}
