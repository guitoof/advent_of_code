import '../src/advent_of_code_1/advent_of_code_1.dart';
import '../src/advent_of_code_1/data_source.dart';
import '../src/advent_of_code_2/advent_of_code_2.dart';
import '../src/advent_of_code_2/data_source.dart';

void main(List<String> arguments) async {
  print("Day 1 :");
  final input1 = await getInput1Data();
  print('Part 1: ${countIncreasingMeasurements(input1)}');
  print(
      'Part 2: ${countIncreasingMeasurementsByWindow(input1, windowSize: 3)}');
  print("--------------------------------------------------------");

  print("Day 2 :");
  final input2 = await getInput2Data();
  print('Part 1: ${getCoordinatesProductForFinalPosition(input2)}');
  print("--------------------------------------------------------");
}
