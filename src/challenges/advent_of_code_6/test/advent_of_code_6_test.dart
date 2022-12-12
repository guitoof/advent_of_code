import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../advent_of_code_6.dart';
import '../../../utils/data_source.dart';
import '../../../utils/test/test_helpers.dart';

void main() {
  dayTestGroup(
    'Day 6',
    solverBuilder: ({required part}) => DailySolver6(day: 6, part: part),
    partTestGroups: {
      1: PartTestGroup(
        (solver, type) {
          final solver6 = castSolverType<DailySolver6>(solver);
          testGroupWithExpectedDataByType(
            'Packet.isMarker',
            expectedDataMap: {
              DataSourceType.example: [
                {'input': 'mjqj', 'output': false},
                {'input': 'jpqm', 'output': true},
              ],
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return true if the packet contains only different characters',
                  () async {
                for (var item in expectedData) {
                  expect(Packet(item['input']).isMarker, item['output']);
                }
              });
            },
          );
          testGroupWithExpectedDataByType(
            'getDataCountToFirstMarker',
            expectedDataMap: {
              DataSourceType.example: [
                {'input': 'bvwbjplbgvbhsrlpgdmjqwftvncz', 'output': 5},
                {'input': 'nppdvjthqldpwncqszvftbrmjlhg', 'output': 6},
                {'input': 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg', 'output': 10},
                {'input': 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw', 'output': 11},
              ],
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the count of characters before the 1st marker is received',
                  () async {
                for (var item in expectedData) {
                  expect(
                      StartOfPacketMarkerSubroutine.getDataCountToFirstMarker(
                          item['input']),
                      item['output']);
                }
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[solve]',
            expectedDataMap: {
              DataSourceType.example: 7,
              DataSourceType.challenge: 1287,
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the count of characters before the 1st marker is received',
                  () async {
                expect(await solver6.solve(forType: type), expectedData);
              });
            },
          );
        },
        skipTypes: [],
      ),
      2: PartTestGroup(
        (solver, type) {
          final solver6 = castSolverType<DailySolver6>(solver);
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
                expect(solver6, isA<DailySolver6>());
                // Use [expectedData] to test the behavior of [someMethod]
                // expect(solver6.someMethod2(), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge, DataSourceType.example],
      ),
    },
  );
}
