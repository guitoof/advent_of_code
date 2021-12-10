import '../utils/data_source.dart';

Future<List<String>> getInput10Data() {
  return getInputData<String>(id: 10, parser: (line) => line);
}
