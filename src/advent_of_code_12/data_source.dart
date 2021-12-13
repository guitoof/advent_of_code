import '../utils/data_source.dart';

Future<List<List<String>>> getInput12Data() {
  return getInputData<List<String>>(
      id: 12, parser: (line) => line.split('-').toList());
}
