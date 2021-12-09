import '../utils/data_source.dart';
import 'advent_of_code_9.dart';

Future<Input> getInput9Data() {
  return getInputData<List<int>>(
      id: 9, parser: (line) => line.split('').map(int.parse).toList());
}
