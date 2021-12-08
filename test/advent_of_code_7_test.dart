import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../src/advent_of_code_7/advent_of_code_7.dart';

void main() {
  group('getFuelConsumption', () {
    test('should return the quantity of fuel used by the crabs to align', () {
      const input = <int>[16, 1, 2, 0, 4, 2, 7, 1, 2, 14];
      expect(getFuelConsumption(input), 37);
    });
  });

  group('getDynamicFuelConsumption', () {
    test(
        'should return the quantity of fuel used by the crabs to align with a dynamic consumption',
        () {
      const input = <int>[16, 1, 2, 0, 4, 2, 7, 1, 2, 14];
      expect(getDynamicFuelConsumption(input), 168);
    });
  });
}
