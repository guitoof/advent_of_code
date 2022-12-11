// import '../src/challenges/advent_of_code_0/advent_of_code_0.dart';

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
  // displayAdventOfCodeResponse(
  //   day: 0,
  //   name: 'Name of the challenge',
  //   part1Response: (await DailySolver0(day: 0, part: 1).solve()),
  //   part2Response: (await DailySolver0(day: 0, part: 2).solve()),
  // );
}
