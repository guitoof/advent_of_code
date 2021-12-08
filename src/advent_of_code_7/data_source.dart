import '../utils/data_source.dart';

Future<List<int>> getInput7Data() async {
  final input = await getInputData<List<int>>(
      id: 7, parser: (line) => line.split(',').map(int.parse).toList());
  return input.first;
}
