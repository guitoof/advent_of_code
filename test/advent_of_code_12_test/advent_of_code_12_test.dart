import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../src/advent_of_code_12/advent_of_code_12.dart';
import '../../src/utils/data_source.dart';

Future<List<List<String>>> getInputData({required int sampleId}) {
  return getInputDataFromFile<List<String>>(
      filePath: 'test/advent_of_code_12_test/data/input_12_$sampleId',
      parser: (line) => line.split('-').toList());
}

void main() {
  group('countPaths', () {
    test(
        'should return the number of paths through this cave system are there that visit small caves at most once',
        () async {
      expect(countPaths(await getInputData(sampleId: 1)), 10);
      expect(countPaths(await getInputData(sampleId: 2)), 19);
      expect(countPaths(await getInputData(sampleId: 3)), 226);
    });
  });
}
