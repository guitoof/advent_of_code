import '../utils/data_source.dart';

dynamic input13Parser(String line) {
  if (line.contains(',')) {
    return line.split(',').toList();
  }
  return line;
}

Future<List<List<dynamic>>> getInput13Data() async {
  List<dynamic> rawData =
      await getInputData<dynamic>(id: 13, parser: input13Parser);
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
