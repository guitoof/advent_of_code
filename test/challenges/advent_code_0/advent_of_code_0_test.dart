import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../../src/challenges/advent_of_code_0/advent_of_code_0.dart';

void main() {
  group('Day 0️⃣0️⃣ -', () {
    group('Part 1️⃣ - ', () {
      test(
          'should return the number of calories of the Elf carrying the max calories',
          () async {
        expect(await computeAnswer(), true);
      });
    });
  });
}
