import '../src/advent_of_code_1/advent_of_code_1.dart';
import '../src/advent_of_code_1/data_source.dart';
import '../src/advent_of_code_2/advent_of_code_2.dart';
import '../src/advent_of_code_2/data_source.dart';
import '../src/advent_of_code_3/advent_of_code_3.dart';
import '../src/advent_of_code_3/data_source.dart';
import '../src/advent_of_code_4/advent_of_code_4.dart';
import '../src/advent_of_code_4/data_source.dart';

void main(List<String> arguments) async {
  print("Day 1 :");
  final input1 = await getInput1Data();
  print('Part 1: ${countIncreasingMeasurements(input1)}');
  print(
      'Part 2: ${countIncreasingMeasurementsByWindow(input1, windowSize: 3)}');
  print("--------------------------------------------------------");

  print("Day 2 :");
  final input2 = await getInput2Data();
  print(
      'Part 1: ${getCoordinatesProductForFinalPosition(moveCommands: input2)}');
  print('Part 2: ${getCoordinatesProductForFinalPosition(
    moveCommands: input2,
    interpretationMethod: CommandInterpretationMethod.aim,
  )}');
  print("--------------------------------------------------------");

  print("Day 3 :");
  final input3 = await getInput3Data();
  print('Part 1: ${getPowerConsumption(report: input3)}');
  print('Part 2: ${getLifeSupportRating(report: input3)}');
  print("--------------------------------------------------------");

  print("Day 4 :");
  final input4 = await getInput4Data();
  print(
      'Part 1: ${getBingoScore(bingoBoards: input4.bingoBoards.map(parseInputBoard).toList(), drawnNumbers: input4.drawnNumbers)}');
  print(
      'Part 2: ${getBingoScore(bingoBoards: input4.bingoBoards.map(parseInputBoard).toList(), drawnNumbers: input4.drawnNumbers, which: BingoBoardWinningPlace.last)}');
  print("--------------------------------------------------------");
}
