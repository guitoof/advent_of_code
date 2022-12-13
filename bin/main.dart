import '../src/challenges/advent_of_code_1/advent_of_code_1.dart';
import '../src/challenges/advent_of_code_2/advent_of_code_2.dart';
import '../src/challenges/advent_of_code_3/advent_of_code_3.dart';
import '../src/challenges/advent_of_code_4/advent_of_code_4.dart';
import '../src/challenges/advent_of_code_5/advent_of_code_5.dart';
import '../src/challenges/advent_of_code_6/advent_of_code_6.dart';
import '../src/challenges/advent_of_code_7/advent_of_code_7.dart';
import '../src/challenges/advent_of_code_8/advent_of_code_8.dart';

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
  displayAdventOfCodeResponse(
    day: 1,
    name: '🍫 Calorie Counting',
    part1Response: (await DailySolver1(day: 1, part: 1).solve()),
    part2Response: (await DailySolver1(day: 1, part: 2).solve()),
  );

  displayAdventOfCodeResponse(
    day: 2,
    name: '🖖 Rock Paper Scissors',
    part1Response: (await DailySolver2(day: 2, part: 1).solve()),
    part2Response: (await DailySolver2(day: 2, part: 2).solve()),
  );

  displayAdventOfCodeResponse(
    day: 3,
    name: '🎒 Rucksack Reorganization',
    part1Response: (await DailySolver3(day: 3, part: 1).solve()),
    part2Response: (await DailySolver3(day: 3, part: 2).solve()),
  );

  displayAdventOfCodeResponse(
    day: 4,
    name: '🧹 Camp Cleanup',
    part1Response: (await DailySolver4(day: 4, part: 1).solve()),
    part2Response: (await DailySolver4(day: 4, part: 2).solve()),
  );

  displayAdventOfCodeResponse(
    day: 5,
    name: '📦 Supply Stacks',
    part1Response: (await DailySolver5(day: 5, part: 1).solve()),
    part2Response: (await DailySolver5(day: 5, part: 2).solve()),
  );

  displayAdventOfCodeResponse(
    day: 6,
    name: '📡 Tuning Trouble',
    part1Response: (await DailySolver6(day: 6, part: 1).solve()),
    part2Response: (await DailySolver6(day: 6, part: 2).solve()),
  );
  displayAdventOfCodeResponse(
    day: 7,
    name: '💾 No Space Left On Device',
    part1Response: (await DailySolver7(day: 7, part: 1).solve()),
    part2Response: (await DailySolver7(day: 7, part: 2).solve()),
  );
  displayAdventOfCodeResponse(
    day: 8,
    name: '🌲 Treetop Tree House',
    part1Response: (await DailySolver8(day: 8, part: 1).solve()),
  );
}
