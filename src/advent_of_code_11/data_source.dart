import '../utils/data_source.dart';
import './advent_of_code_11.dart';

Future<Input> getInput11Data() {
  return getInputData<List<int>>(
      id: 11, parser: (line) => line.split('').map(int.parse).toList());
}
