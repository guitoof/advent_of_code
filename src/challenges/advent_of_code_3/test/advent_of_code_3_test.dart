import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../advent_of_code_3.dart';
import '../../../utils/data_source.dart';
import '../../../utils/test/test_helpers.dart';

void main() {
  dayTestGroup(
    'Day 3',
    solverBuilder: ({required part}) => DailySolver3(day: 3, part: part),
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
            '[solve(part: 1)]',
            expectedDataMap: {
              DataSourceType.example: 157,
              DataSourceType.challenge: 8298,
            },
            type: type,
            body: ({expectedData}) {
              test(
                  '''should return the sum of the priority of each item appearing in both compartments''',
                  () async {
                expect(await solver3.solve(forType: type), expectedData);
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
            '[getRucksacksContentByGroup]',
            expectedDataMap: {
              DataSourceType.example: [
                [
                  'vJrwpWtwJgWrhcsFMMfFFhFp',
                  'jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL',
                  'PmmdzqPrVvPwwTWBwg',
                ],
                [
                  'wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn',
                  'ttgJtRGJQctTZtZT',
                  'CrZsJsPPZsGzwwsLwLmpwMDw',
                ]
              ],
            },
            type: type,
            body: ({expectedData}) {
              test('should return all rucksacks by group', () async {
                expect(solver3.getRucksacksContentByGroup(), expectedData);
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[getBadgesByGroup]',
            expectedDataMap: {
              DataSourceType.example: ['r', 'Z'],
            },
            type: type,
            body: ({expectedData}) {
              test('should return all badges item by group', () async {
                expect(solver3.getBadgesByGroup(), expectedData);
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[getBadgePrioritiesByGroup]',
            expectedDataMap: {
              DataSourceType.example: [18, 52],
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the priorities all badges priority for all groups',
                  () async {
                expect(solver3.getBadgePrioritiesByGroup(), expectedData);
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[solve(part: 2)]',
            expectedDataMap: {
              DataSourceType.example: 70,
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the sum of all badges priority for all groups',
                  () async {
                expect(await solver3.solve(forType: type), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
    },
  );
}
