import '../src/challenges/advent_of_code_1/advent_of_code_1.dart';
import '../src/challenges/advent_of_code_2/advent_of_code_2.dart';
import '../src/challenges/advent_of_code_3/advent_of_code_3.dart';

void displayAdventOfCodeResponse({
  required int day,
  String name = '',
  dynamic part1Response,
  dynamic part2Response,
}) async {
  print("--- 📆 Day $day: $name ---");
  if (part1Response != null) print('⭐️ Part 1: $part1Response');
  if (part2Response != null) print('⭐️ Part 2: $part2Response');
  print("--------------------------------------------------------");
}

void main(List<String> arguments) async {
  final solver1 = DailySolver1(day: 1);
  displayAdventOfCodeResponse(
    day: 1,
    name: '🍫 Calorie Counting',
    part1Response: (await solver1.solve(part: 1)),
    part2Response: (await solver1.solve(part: 2)),
  );

  final solver2 = DailySolver2(day: 2);
  displayAdventOfCodeResponse(
    day: 2,
    name: '🖖 Rock Paper Scissors',
    part1Response: (await solver2.solve(part: 1)),
    part2Response: (await solver2.solve(part: 2)),
  );

  final solver3 = DailySolver3(day: 3);
  displayAdventOfCodeResponse(
    day: 3,
    name: '🎒 Rucksack Reorganization',
    part1Response: (await solver3.solve(part: 1)),
  );
}
