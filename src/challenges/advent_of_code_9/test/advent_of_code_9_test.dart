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
                  'initial': ShortRope(head: Point(2, 1), tail: Point(1, 1)),
                  'move': {
                    'direction': Direction.right,
                  },
                  'final': ShortRope(head: Point(3, 1), tail: Point(2, 1)),
                },
                {
                  'initial': ShortRope(head: Point(4, 5), tail: Point(4, 6)),
                  'move': {
                    'direction': Direction.down,
                  },
                  'final': ShortRope(head: Point(4, 4), tail: Point(4, 5)),
                },
                {
                  'initial': ShortRope(head: Point(3, 1), tail: Point(2, 0)),
                  'move': {
                    'direction': Direction.up,
                  },
                  'final': ShortRope(head: Point(3, 2), tail: Point(3, 1)),
                },
                {
                  'initial': ShortRope(head: Point(2, 2), tail: Point(1, 1)),
                  'move': {
                    'direction': Direction.right,
                  },
                  'final': ShortRope(head: Point(3, 2), tail: Point(2, 2)),
                }
              ],
            },
            type: type,
            body: ({expectedData}) {
              test('should return the Tail position after 1 move to the RIGHT',
                  () async {
                for (var data in expectedData) {
                  final rope = data['initial'] as ShortRope;
                  final move = data['move'] as Map<String, dynamic>;
                  final finalRope = data['final'] as ShortRope;
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
            'getUniqueTailVisitedPositionsCountForShortRope',
            expectedDataMap: {
              DataSourceType.example:
                  88, // was 13 with the example from the 1st part
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return number of unique positions visited by the tail',
                  () async {
                solver9.moveShortRope();
                expect(solver9.getUniqueTailVisitedPositionsCountForShortRope(),
                    expectedData);
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
            'getUniqueTailVisitedPositionsCountForLongRope',
            expectedDataMap: {
              DataSourceType.example: 36,
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the number of uniquely visited positions for the tail of a long rope',
                  () async {
                solver9.moveLongRope();
                expect(solver9.getUniqueTailVisitedPositionsCountForLongRope(),
                    expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
    },
  );
}
