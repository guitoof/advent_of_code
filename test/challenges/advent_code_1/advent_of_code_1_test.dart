import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../../src/challenges/advent_of_code_1/advent_of_code_1.dart';

late DailySolver1 solver;

void main() {
  group('Day 0️⃣1️⃣ -', () {
    setUpAll(() {
      solver = DailySolver1(day: 1, name: 'Day 1 - Tester Solver');
    });

    group('Part 1️⃣ - ', () {
      group('Example', () {
        setUpAll(() async {
          await solver.loadInputData(part: 0);
        });
        group('[getFoodPayloadsByElf]', () {
          test(
              'should return the list of list of food items carried by each elf',
              () async {
            expect(
              solver.foodPayloadByElf,
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
            expect(await solver.getMaxNumberOfCaloriesByElf(), 24000);
          });
        });
      });
    });
    group('Part 2️⃣ - ', () {
      group('Example', () {
        setUpAll(() async {
          await solver.loadInputData(part: 2);
        });
        group('[getTop3MaxNumberOfCalories]', () {
          test('should return the list of list of the top 3 elves', () async {
            expect(
              solver.getTop3MaxNumberOfCalories()..sort(),
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
            expect(await solver.getTotalTop3MaxNumberOfCalories(), 45000);
          });
        });
      });
    });
  });
}
