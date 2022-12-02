import '../src/challenges/advent_of_code_1/advent_of_code_1.dart';

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
  final solver = DailySolver1(day: 1, name: '🍫 Calorie Counting');
  displayAdventOfCodeResponse(
    day: 1,
    name: '🍫 Calorie Counting',
    part1Response: (await solver.solve(part: 1)),
    part2Response: (await solver.solve(part: 2)),
  );
}
