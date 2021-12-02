import '../src/utils/data_source.dart';
import '../src/advent_of_code_1.dart';

void main(List<String> arguments) async {
  final input = await getInputData(id: 1);
  print('Part 1: ${countIncreasingMeasurements(input)}');
  print('Part 2: ${countIncreasingMeasurementsByWindow(input, windowSize: 3)}');
}
