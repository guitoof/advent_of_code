import '../utils/data_source.dart';

Future<List<List<int>>> getInput3Data() async {
  return getInputData<List<int>>(
      id: 3, parser: (line) => line.split('').map(int.parse).toList());
}
