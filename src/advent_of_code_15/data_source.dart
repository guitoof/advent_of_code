import '../utils/data_source.dart';
import 'path_finding_resolver.dart';

List<int> input15Parser(String line) => line.split('').map(int.parse).toList();

Future<Input> getInput15Data() {
  return getInputData<List<int>>(id: 15, parser: input15Parser);
}
