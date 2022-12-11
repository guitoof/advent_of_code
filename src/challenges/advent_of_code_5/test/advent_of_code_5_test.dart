import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../advent_of_code_5.dart';
import '../../../utils/data_source.dart';
import '../../../utils/test/test_helpers.dart';

void main() {
  dayTestGroup(
    'Day 5',
    solverBuilder: ({required part}) => DailySolver5(day: 5, part: part),
    partTestGroups: {
      1: PartTestGroup(
        (solver, type) {
          final solver5 = castSolverType<DailySolver5>(solver);
          group(
            'CargoBay',
            () {
              testGroupWithExpectedDataByType(
                '[loadFromDrawing]',
                expectedDataMap: {
                  DataSourceType.example: {
                    'input': [
                      '    [D]    ',
                      '[N] [C]    ',
                      '[Z] [M] [P]',
                      '  1   2   3 '
                    ],
                    'output': CargoBay.ofStacksCount(3)
                      ..loadCrateToStack(Crate(label: 'Z'), 1)
                      ..loadCrateToStack(Crate(label: 'M'), 2)
                      ..loadCrateToStack(Crate(label: 'P'), 3)
                      ..loadCrateToStack(Crate(label: 'N'), 1)
                      ..loadCrateToStack(Crate(label: 'C'), 2)
                      ..loadCrateToStack(Crate(label: 'D'), 2)
                  },
                },
                type: type,
                body: ({expectedData}) {
                  test(
                      'should parse the raw drawing into a fully loaded [CargoBay]',
                      () async {
                    expect(CargoBay.loadFromDrawing(expectedData['input']),
                        expectedData['output']);
                  });
                },
              );
            },
          );
          testGroupWithExpectedDataByType(
            '[getInitialTopCratesLabels]',
            expectedDataMap: {
              DataSourceType.example: 'NDP',
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the labels of all the top cranes as laid out initially',
                  () async {
                expect(solver5.getInitialTopCratesLabels(), expectedData);
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[rearrangementProcedure]',
            expectedDataMap: {
              DataSourceType.example:
                  '[Move (1) from (2) to (1), Move (3) from (1) to (3), Move (2) from (2) to (1), Move (1) from (1) to (2)]',
            },
            type: type,
            body: ({expectedData}) {
              test('should return the parsed rearrangement procedure',
                  () async {
                expect(solver5.rearrangementProcedure.toString(), expectedData);
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[getRearrangedTopCratesLabels]',
            expectedDataMap: {
              DataSourceType.example: 'CMZ',
              DataSourceType.challenge: 'SHMSDGZVC',
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the labels of all the top cranes after rearrangement',
                  () async {
                expect(solver5.getRearrangedTopCratesLabels(), expectedData);
              });
            },
          );
        },
        skipTypes: [],
      ),
      2: PartTestGroup(
        (solver, type) {
          final solver5 = castSolverType<DailySolver5>(solver);
          testGroupWithExpectedDataByType(
            '[getRearrangedTopCratesLabels]',
            expectedDataMap: {
              DataSourceType.example: 'MCD',
              DataSourceType.challenge: 'VRZGHDFBQ',
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the labels of all the top cranes after rearrangement',
                  () async {
                expect(solver5.getRearrangedTopCratesLabels(), expectedData);
              });
            },
          );
        },
        skipTypes: [],
      ),
    },
  );
}
