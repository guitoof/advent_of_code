import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../src/advent_of_code_14/advent_of_code_14.dart';
import '../../src/advent_of_code_14/data_source.dart';
import '../../src/utils/data_source.dart' hide getInputData;

Future<List<dynamic>> getInputData() async {
  final rawData =
      (await getTestInputData<dynamic>(id: 14, parser: input14Parser))
          .where((line) => line != '')
          .toList();
  return [rawData.first, rawData.where((line) => line.contains('->')).toList()];
}

void main() {
  group('getPolymereCompositionScore', () {
    test(
        'should return the difference between the most & least common element in the produced polymere',
        () async {
      final input = await getInputData();
      expect(getPolymereCompositionScore(input, steps: 10), 1588);
    });
  });
}
