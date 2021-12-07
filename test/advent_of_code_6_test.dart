import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../src/advent_of_code_6/advent_of_code_6.dart';

void main() {
  group('simulateLanternFishProduction', () {
    test('should return 5 fishes after 0 days when starting with "3,4,3,1,2"',
        () {
      const input = <int>[3, 4, 3, 1, 2];
      expect(simulateLanternFishProduction(input, days: 0), 5);
    });

    test('should return 26 fishes after 18 days when starting with "3,4,3,1,2"',
        () {
      const input = <int>[3, 4, 3, 1, 2];
      expect(simulateLanternFishProduction(input, days: 18), 26);
    });

    test(
        'should return 5934 fishes after 80 days when starting with "3,4,3,1,2"',
        () {
      const input = <int>[3, 4, 3, 1, 2];
      expect(simulateLanternFishProduction(input, days: 80), 5934);
    });
  });
  group('simulateOptimizedLanternFishProduction', () {
    test('should return 5 fishes after 0 days when starting with "3,4,3,1,2"',
        () {
      const input = <int>[3, 4, 3, 1, 2];
      expect(simulateOptimizedLanternFishProduction(input, days: 0), 5);
    });

    test('should return 26 fishes after 18 days when starting with "3,4,3,1,2"',
        () {
      const input = <int>[3, 4, 3, 1, 2];
      expect(simulateOptimizedLanternFishProduction(input, days: 18), 26);
    });

    test(
        'should return 5934 fishes after 80 days when starting with "3,4,3,1,2"',
        () {
      const input = <int>[3, 4, 3, 1, 2];
      expect(simulateOptimizedLanternFishProduction(input, days: 80), 5934);
    });
  });
}
