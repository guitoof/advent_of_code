import '../utils/data_source.dart';
import 'advent_of_code_15.dart';

List<int> input15Parser(String line) => line.split('').map(int.parse).toList();

Future<Input> getInput15Data() {
  return getInputData<List<int>>(id: 15, parser: input15Parser);
}
