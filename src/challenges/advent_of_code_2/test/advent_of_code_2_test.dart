import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../advent_of_code_2.dart';
import '../../../utils/data_source.dart';
import '../../../utils/test/test_helpers.dart';

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
              test(
                  '''should return the score if the 2nd column is the hand we should play''',
                  () async {
                solver2.loadMatchesFromHands();
                expect(solver2.getRockPaperScissorsScore(), expectedData);
              });
            },
          );
        },
        skipTypes: [],
      ),
      2: PartTestGroup(
        (solver, type) {
          final solver2 = castSolverType<DailySolver2>(solver);
          testGroupWithExpectedDataByType(
            '[getScoreByMatch]',
            expectedDataMap: {
              DataSourceType.example: [4, 1, 7],
            },
            type: type,
            body: ({expectedData}) {
              test('''should return the score of each match,
                  if the 2nd column is the expected outcome''', () async {
                solver2.loadMatchesFromHandAndOutcome();
                expect(solver2.getScoreByMatch(), expectedData);
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[getRockPaperScissorsScore]',
            expectedDataMap: {
              DataSourceType.example: 12,
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the score if the 2nd column is the expected outcome',
                  () async {
                solver2.loadMatchesFromHandAndOutcome();
                expect(solver2.getRockPaperScissorsScore(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
    },
  );
}
