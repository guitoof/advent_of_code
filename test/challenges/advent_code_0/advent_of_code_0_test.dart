import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../../src/challenges/advent_of_code_0/advent_of_code_0.dart';

late DailySolver0 solver;

void main() {
  group('Day 0️⃣0️⃣ -', () {
    setUpAll(() {
      solver = DailySolver0(day: 0, name: 'Day 0 - Tester Solver');
    });

    group('Part 1️⃣ - ', () {
      group('Example - ', () {
        setUpAll(() async {
          await solver.loadInputData(part: 0);
        });
        group('[someMethod]', () {
          test('should...', () async {
            /// Expect things here
          });
        });
      });
      group('Response - ', () {
        setUpAll(() async {
          await solver.loadInputData(part: 1);
        });
        group('[someMethod]', () {
          test('should...', () async {
            /// Expect things here
          });
        });
      });
    });
  });
}
