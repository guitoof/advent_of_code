import 'dart:math';

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../advent_of_code_9.dart';
import '../../../utils/data_source.dart';
import '../../../utils/test/test_helpers.dart';

void main() {
  dayTestGroup(
    'Day 9',
    solverBuilder: ({required part}) => DailySolver9(day: 9, part: part),
    partTestGroups: {
      1: PartTestGroup(
        (solver, type) {
          final solver9 = castSolverType<DailySolver9>(solver);
          testGroupWithExpectedDataByType(
            'Rope.moveHeadByOne',
            expectedDataMap: {
              DataSourceType.example: [
                {
                  'initial': Rope(head: Point(2, 1), tail: Point(1, 1)),
                  'move': {
                    'direction': Direction.right,
                  },
                  'final': Rope(head: Point(3, 1), tail: Point(2, 1)),
                },
                {
                  'initial': Rope(head: Point(4, 5), tail: Point(4, 6)),
                  'move': {
                    'direction': Direction.down,
                  },
                  'final': Rope(head: Point(4, 4), tail: Point(4, 5)),
                },
                {
                  'initial': Rope(head: Point(3, 1), tail: Point(2, 0)),
                  'move': {
                    'direction': Direction.up,
                  },
                  'final': Rope(head: Point(3, 2), tail: Point(3, 1)),
                },
                {
                  'initial': Rope(head: Point(2, 2), tail: Point(1, 1)),
                  'move': {
                    'direction': Direction.right,
                  },
                  'final': Rope(head: Point(3, 2), tail: Point(2, 2)),
                }
              ],
            },
            type: type,
            body: ({expectedData}) {
              test('should return the Tail position after 1 move to the RIGHT',
                  () async {
                for (var data in expectedData) {
                  final rope = data['initial'] as Rope;
                  final move = data['move'] as Map<String, dynamic>;
                  final finalRope = data['final'] as Rope;
                  rope.moveHeadByOne(
                    direction: move['direction'] as Direction,
                  );
                  expect(
                    rope,
                    finalRope,
                  );
                }
              });
            },
          );
          testGroupWithExpectedDataByType(
            'getUniqueTailVisitedPositionsCount',
            expectedDataMap: {
              DataSourceType.example: 13,
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return number of unique positions visited by the tail',
                  () async {
                solver9.moveRope();
                expect(
                    solver9.getUniqueTailVisitedPositionsCount(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
      2: PartTestGroup(
        (solver, type) {
          final solver9 = castSolverType<DailySolver9>(solver);
          testGroupWithExpectedDataByType(
            '[someMethod2] relevant to part 2',
            expectedDataMap: {
              DataSourceType.example: 'Expected Data for Example',
              // Challenge case will be skipped
              // if [DataSourceType.challenge] is missing (null)
            },
            type: type,
            body: ({expectedData}) {
              test('test some behavior of [someMethod2]', () async {
                expect(solver9, isA<DailySolver9>());
                // Use [expectedData] to test the behavior of [someMethod]
                // expect(solver9.someMethod2(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge, DataSourceType.example],
      ),
    },
  );
}
