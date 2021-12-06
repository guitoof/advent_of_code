import '../utils/data_source.dart';

Future<List<List<List<int>>>> getInput5Data() {
  return getInputData<List<List<int>>>(id: 5, parser: (line) {
    return line.split('->').map((e) => e.split(',').map(int.parse).toList()).toList();
  });
}
