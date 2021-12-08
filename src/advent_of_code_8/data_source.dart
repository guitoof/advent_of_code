import '../utils/data_source.dart';

Future<List<List<List<String>>>> getInput8Data() {
  return getInputData<List<List<String>>>(
    id: 8,
    parser: (line) => line
        .split('|')
        .map((s) => s.split(' ').where((w) => w != ' ').toList())
        .toList(),
  );
}
