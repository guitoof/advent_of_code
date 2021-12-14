import '../utils/data_source.dart';
import 'advent_of_code_14.dart';

dynamic input14Parser(String line) => line;

Future<Input> getInput14Data() async {
  final rawData = (await getInputData<dynamic>(id: 14, parser: input14Parser))
      .where((line) => line != '')
      .toList();
  return [
    rawData.first,
    rawData.where((line) => line.contains('->')).toList(),
  ];
}
