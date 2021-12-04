import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../src/advent_of_code_3/advent_of_code_3.dart';

void main() {
  group('binaryToInt', () {
    test('should transform "00000" into 0', () {
      expect(binaryToInt('00000'), 0);
    });
    test('should transform "00001" into 1', () {
      expect(binaryToInt('00001'), 1);
    });
    test('should transform "00010" into 2', () {
      expect(binaryToInt('00010'), 2);
    });
    test('should transform "000100" into 4', () {
      expect(binaryToInt('000100'), 4);
    });
    test('should transform "00101" into 5', () {
      expect(binaryToInt('00101'), 5);
    });
    test('should transform "01000" into 8', () {
      expect(binaryToInt('01000'), 8);
    });
    test('should transform "10110" into 22', () {
      expect(binaryToInt('10110'), 22);
    });
  });

  test('should return the power consumption indicated by the given report', () {
    const input = [
      [0, 0, 1, 0, 0],
      [1, 1, 1, 1, 0],
      [1, 0, 1, 1, 0],
      [1, 0, 1, 1, 1],
      [1, 0, 1, 0, 1],
      [0, 1, 1, 1, 1],
      [0, 0, 1, 1, 1],
      [1, 1, 1, 0, 0],
      [1, 0, 0, 0, 0],
      [1, 1, 0, 0, 1],
      [0, 0, 0, 1, 0],
      [0, 1, 0, 1, 0],
    ];
    expect(getPowerConsumption(report: input), 198);
  });

  test('should return the life support rating by the given report', () {
    const input = [
      [0, 0, 1, 0, 0],
      [1, 1, 1, 1, 0],
      [1, 0, 1, 1, 0],
      [1, 0, 1, 1, 1],
      [1, 0, 1, 0, 1],
      [0, 1, 1, 1, 1],
      [0, 0, 1, 1, 1],
      [1, 1, 1, 0, 0],
      [1, 0, 0, 0, 0],
      [1, 1, 0, 0, 1],
      [0, 0, 0, 1, 0],
      [0, 1, 0, 1, 0],
    ];
    expect(getLifeSupportRating(report: input), 230);
  });
}
