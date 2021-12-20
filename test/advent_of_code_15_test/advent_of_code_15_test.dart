import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../src/advent_of_code_15/advent_of_code_15.dart';
import '../../src/advent_of_code_15/path_finding_resolver.dart';
import '../../src/advent_of_code_15/dijkstra.dart';
import '../../src/advent_of_code_15/a_star.dart';
import '../../src/advent_of_code_15/data_source.dart';
import '../../src/utils/data_source.dart' hide getInputData;

Future<Input> getInputData() async {
  return getTestInputData<List<int>>(id: 15, parser: input15Parser);
}

void main() {
  group('getTotalLowestRisk', () {
    test('should return the total risk following the lowest risk path',
        () async {
      final input = await getInputData();
      expect(getTotalLowestRisk(input), 40);
    });
  });
  group('getTotalLowestRiskWithExpandedMap', () {
    test(
        'should return the total risk following the lowest risk path of the expanded map',
        () async {
      final input = await getInputData();
      expect(getTotalLowestRisk(input, expansionFactor: 5), 315);
    });
  });
  group('expandMapByTiles', () {
    test(
        'should the map expanded by N tiles following the tile building process',
        () async {
      final input = [
        [8]
      ];
      expect(expandMapByTiles(input, tiles: 5), [
        [8, 9, 1, 2, 3],
        [9, 1, 2, 3, 4],
        [1, 2, 3, 4, 5],
        [2, 3, 4, 5, 6],
        [3, 4, 5, 6, 7],
      ]);
    });
    test('should return 4 for (12,2) and 1 for (13,2)', () async {
      final input = await getInputData();
      final transformedMap = expandMapByTiles(input, tiles: 5);
      expect(transformedMap[12][2], 4);
      expect(transformedMap[13][2], 1);
    });
  });
  group('AStarResolver', () {
    group('getRiskLevelForPosition', () {
      test(
          'should the map expanded by N tiles following the tile building process',
          () async {
        final input = [
          [8]
        ];
        const expansionFactor = 5;
        final resolver =
            AStarResolver.fromInput(input, expansionFactor: expansionFactor);
        final expected = [
          for (var i = 0; i < expansionFactor; i++)
            {
              for (var j = 0; j < expansionFactor; j++)
                resolver.getRiskLevelForPosition(j, i)
            }
        ];
        expect(expected, [
          [8, 9, 1, 2, 3],
          [9, 1, 2, 3, 4],
          [1, 2, 3, 4, 5],
          [2, 3, 4, 5, 6],
          [3, 4, 5, 6, 7],
        ]);
      });
      test('should return 4 for (12,2) and 1 for (13,2)', () async {
        final input = await getInputData();
        final resolver = AStarResolver.fromInput(input, expansionFactor: 5);
        expect(resolver.getRiskLevelForPosition(2, 12), 4);
        expect(resolver.getRiskLevelForPosition(2, 13), 1);
      });
    });
  });
}
