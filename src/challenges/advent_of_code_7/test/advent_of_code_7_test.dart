import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../advent_of_code_7.dart';
import '../../../utils/data_source.dart';
import '../../../utils/test/test_helpers.dart';

void main() {
  dayTestGroup(
    'Day 7',
    solverBuilder: ({required part}) => DailySolver7(day: 7, part: part),
    partTestGroups: {
      1: PartTestGroup(
        (solver, type) {
          final solver7 = castSolverType<DailySolver7>(solver);
          testGroupWithExpectedDataByType(
            '[reconstructSystem]',
            expectedDataMap: {
              DataSourceType.example: {
                'e': 584,
                'a': 94853,
                'd': 24933642,
                '/': 48381165
              },
            },
            type: type,
            body: ({expectedData}) {
              test(
                  "should construct the system's structure with the right size for each directory",
                  () async {
                (expectedData as Map<String, int>).forEach((key, value) {
                  expect(
                      solver7.reconstructSystem().findByName(key)?.size, value);
                });
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[getDirectoriesOfMaxSize]',
            expectedDataMap: {
              DataSourceType.example: {
                'e': 584,
                'a': 94853,
              },
            },
            type: type,
            body: ({expectedData}) {
              test(
                  "should return the directories with a size < to the given threshold",
                  () async {
                (expectedData as Map<String, int>).forEach((key, value) {
                  expect(
                    SystemSpaceMaker.getDirectoriesOfMaxSize(
                            directory: solver7.reconstructSystem(),
                            threshold: 100000)
                        .map((d) => d.size)
                        .toList(),
                    contains(value),
                  );
                });
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
      2: PartTestGroup(
        (solver, type) {
          final solver7 = castSolverType<DailySolver7>(solver);
          testGroupWithExpectedDataByType(
            '[amountOfFreeSpaceNeeded]',
            expectedDataMap: {
              DataSourceType.example: 8381165,
            },
            type: type,
            body: ({expectedData}) {
              test('compute the amount of space needed', () async {
                expect(solver7.amountOfFreeSpaceNeeded, expectedData);
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[getSortedDeletionCandidates]',
            expectedDataMap: {
              DataSourceType.example: [24933642, 48381165],
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return all directories whose deletion would free enough space',
                  () async {
                expect(
                    solver7.spaceMaker
                        .getSortedDeletionCandidates()
                        .map((d) => d.size)
                        .toList(),
                    expectedData);
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[solve]',
            expectedDataMap: {
              DataSourceType.example: 24933642,
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the smallest of all directories whose deletion would free enough space',
                  () async {
                expect(await solver7.solve(forType: type), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
    },
  );
}
