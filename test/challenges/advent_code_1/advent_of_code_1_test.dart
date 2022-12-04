import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../../src/challenges/advent_of_code_1/advent_of_code_1.dart';
import '../../../src/utils/data_source.dart';
import '../../test_helpers.dart';

void main() {
  dayTestGroup(
    'Day 1',
    solverBuilder: () => DailySolver1(day: 1),
    partTestGroups: {
      1: PartTestGroup(
        (solver, type) {
          final solver1 = castSolverType<DailySolver1>(solver);
          testGroupWithExpectedDataByType(
            '[foodPayloadByElf]',
            expectedDataMap: {
              DataSourceType.example: [
                [1000, 2000, 3000],
                [4000],
                [5000, 6000],
                [7000, 8000, 9000],
                [10000],
              ],
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the list of list of food items carried by each elf',
                  () async {
                expect(
                  solver1.foodPayloadByElf,
                  equals(expectedData),
                );
              });
            },
          );
          testGroupWithExpectedDataByType('[getMaxNumberOfCaloriesByElf]',
              expectedDataMap: {
                DataSourceType.example: 24000,
                DataSourceType.challenge: 74198,
              },
              type: type, body: ({expectedData}) {
            test(
                'should return the number of calories of the Elf carrying the max calories',
                () async {
              expect(
                await solver1.getMaxNumberOfCaloriesByElf(),
                expectedData,
              );
            });
          });
        },
        skipTypes: [],
      ),
      2: PartTestGroup(
        (solver, type) {
          final solver1 = castSolverType<DailySolver1>(solver);
          testGroupWithExpectedDataByType('[getTop3MaxNumberOfCalories]',
              expectedDataMap: {
                DataSourceType.example: [24000, 11000, 10000]..sort(),
                DataSourceType.challenge: [67758, 67958, 74198]..sort(),
              },
              type: type, body: ({expectedData}) {
            test('should return the list of list of the top 3 elves', () async {
              expect(
                solver1.getTop3MaxNumberOfCalories()..sort(),
                equals(expectedData),
              );
            });
          });
          testGroupWithExpectedDataByType('[getTotalTop3MaxNumberOfCalories]',
              expectedDataMap: {
                DataSourceType.example: 45000,
                DataSourceType.challenge: 209914,
              },
              type: type, body: ({expectedData}) {
            test(
                'should return the number of calories of the top 3 Elves carrying the max calories',
                () async {
              expect(await solver1.getTotalTop3MaxNumberOfCalories(),
                  expectedData);
            });
          });
        },
        skipTypes: [],
      ),
    },
  );
}
