import '../utils/data_source.dart';

Future<List<int>> getInput1Data() async {
  return getInputData<int>(id: 1, parser: int.parse);
}
