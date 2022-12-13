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
              test('should return the number of trees visible from any edge',
                  () async {
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
              DataSourceType.example: [
                {
                  'x': 2,
                  'y': 1,
                  'viewingDistances': {
                    'up': 1,
                    'left': 1,
                    'right': 2,
                    'down': 2,
                  },
                  'scenicScore': 4,
                },
                {
                  'x': 2,
                  'y': 3,
                  'viewingDistances': {
                    'up': 2,
                    'left': 2,
                    'down': 1,
                    'right': 2,
                  },
                  'scenicScore': 8,
                },
              ],
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should compute viewing distances & scenic score for the given trees',
                  () async {
                for (Map<String, Object> data in expectedData) {
                  expect(
                    solver8.getViewingDistanceRight(
                        data['y'] as int, data['x'] as int),
                    (data['viewingDistances'] as Map<String, int>)['right'],
                  );
                  expect(
                    solver8.getViewingDistanceLeft(
                        data['y'] as int, data['x'] as int),
                    (data['viewingDistances'] as Map<String, int>)['left'],
                  );
                  expect(
                    solver8.getViewingDistanceUp(
                        data['y'] as int, data['x'] as int),
                    (data['viewingDistances'] as Map<String, int>)['up'],
                  );
                  expect(
                    solver8.getViewingDistanceDown(
                        data['y'] as int, data['x'] as int),
                    (data['viewingDistances'] as Map<String, int>)['down'],
                  );
                  expect(
                    solver8.getScenicScore(data['y'] as int, data['x'] as int),
                    data['scenicScore'] as int,
                  );
                }
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[getBestScenicScore]',
            expectedDataMap: {
              DataSourceType.example: 8,
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the highest scenic score from the entire forest',
                  () async {
                expect(solver8.getBestScenicScore(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
    },
  );
}
