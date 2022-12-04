import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../../src/challenges/advent_of_code_1/advent_of_code_1.dart';
import '../../../src/utils/data_source.dart';
import '../../test_helpers.dart';

void main() {
  dayTestGroup(
    day: 1,
    solverBuilder: () => DailySolver1(
      day: 1,
      name: 'Day 0 - Tester Solver',
    ),
    partTestGroups: {
      1: PartTestGroup(
        (solver) {
          final solver1 = castSolverType<DailySolver1>(solver);
          group('[foodPayloadByElf]', () {
            test(
                'should return the list of list of food items carried by each elf',
                () async {
              expect(
                solver1.foodPayloadByElf,
                equals([
                  [1000, 2000, 3000],
                  [4000],
                  [5000, 6000],
                  [7000, 8000, 9000],
                  [10000],
                ]),
              );
            });
          });
          group('[getMaxNumberOfCaloriesByElf]', () {
            test(
                'should return the number of calories of the Elf carrying the max calories',
                () async {
              expect(await solver1.getMaxNumberOfCaloriesByElf(), 24000);
            });
          });
        },
        skipTypes: [DataSourceType.challenge],
      ),
      2: PartTestGroup(
        (solver) {
          final solver1 = castSolverType<DailySolver1>(solver);
          group('[getTop3MaxNumberOfCalories]', () {
            test('should return the list of list of the top 3 elves', () async {
              expect(
                solver1.getTop3MaxNumberOfCalories()..sort(),
                equals([
                  24000,
                  11000,
                  10000,
                ]..sort()),
              );
            });
          });
          group('[getTotalTop3MaxNumberOfCalories]', () {
            test(
                'should return the number of calories of the top 3 Elves carrying the max calories',
                () async {
              expect(await solver1.getTotalTop3MaxNumberOfCalories(), 45000);
            });
          });
        },
        skipTypes: [DataSourceType.challenge, DataSourceType.example],
      ),
    },
  );
}
