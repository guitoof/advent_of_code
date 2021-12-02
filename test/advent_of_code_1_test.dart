import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../src/advent_of_code_1/advent_of_code_1.dart';

void main() {
  test(
      'should return the number of measurements larger than the previsous measurement',
      () {
    const input = [
      199,
      200,
      208,
      210,
      200,
      207,
      240,
      269,
      260,
      263,
    ];
    expect(countIncreasingMeasurements(input), 7);
  });

  test(
      'should return the number of measurement window sum larger than the previsous measurement window sum',
      () {
    const input = [
      199,
      200,
      208,
      210,
      200,
      207,
      240,
      269,
      260,
      263,
    ];
    expect(countIncreasingMeasurementsByWindow(input, windowSize: 3), 5);
  });
}
