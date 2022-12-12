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
                  'should return true if the "packet" contains only different characters',
                  () async {
                for (var item in expectedData) {
                  expect(
                      MarkerCandidate(item['input']).isMarker, item['output']);
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
                      StartOfPacketMarkerSubroutine.getFirstPacketSize(
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
                  'should return the count of characters before the 1st packet marker is received',
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
            'Message.isMarker',
            expectedDataMap: {
              DataSourceType.example: [
                {'input': 'pqmgbljsphdztn', 'output': false},
                {'input': 'qmgbljsphdztnv', 'output': true},
              ],
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return true if the "message" contains only different characters',
                  () async {
                for (var item in expectedData) {
                  expect(
                      MarkerCandidate(item['input']).isMarker, item['output']);
                }
              });
            },
          );
          testGroupWithExpectedDataByType(
            'getDataCountToFirstMarker',
            expectedDataMap: {
              DataSourceType.example: [
                {'input': 'bvwbjplbgvbhsrlpgdmjqwftvncz', 'output': 23},
                {'input': 'nppdvjthqldpwncqszvftbrmjlhg', 'output': 23},
                {'input': 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg', 'output': 29},
                {'input': 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw', 'output': 26},
              ],
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the count of characters before the 1st marker is received',
                  () async {
                for (var item in expectedData) {
                  expect(
                      StartOfPacketMarkerSubroutine.getFirstMessageSize(
                          item['input']),
                      item['output']);
                }
              });
            },
          );
          testGroupWithExpectedDataByType(
            '[solve]',
            expectedDataMap: {
              DataSourceType.example: 19,
              DataSourceType.challenge: 3716,
            },
            type: type,
            body: ({expectedData}) {
              test(
                  'should return the count of characters before the 1st message marker is received',
                  () async {
                expect(await solver6.solve(forType: type), expectedData);
              });
            },
          );
        },
        skipTypes: [DataSourceType.challenge],
      ),
    },
  );
}
