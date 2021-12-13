import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../src/advent_of_code_13/advent_of_code_13.dart';
import '../../src/advent_of_code_13/data_source.dart';
import '../../src/utils/data_source.dart' hide getInputData;

Future<List<List<dynamic>>> getInputData() async {
  List<dynamic> rawData =
      await getTestInputData<dynamic>(id: 13, parser: input13Parser);
  final List<List<int>> dotsPosition = rawData
      .whereType<List>()
      .map((item) => item.map((point) => int.parse(point)).toList())
      .toList();
  final foldingInstructions =
      rawData.whereType<String>().where((item) => item != '').toList();
  return [
    dotsPosition,
    foldingInstructions,
  ];
}

void main() {
  group('countVisibleDotsAfterFoldingOnce', () {
    test('should the number of visible dots after folding once', () async {
      Input input = await getInputData();
      expect(countVisibleDotsAfterFoldingOnce(input), 17);
    });
  });
}
