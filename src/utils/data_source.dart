import 'dart:convert';
import 'dart:io';

enum DataSourceType { example, challenge }

Future<List<T>> getInputData<T>({
  required int day,
  required DataSourceType type,
  required T Function(String) lineParser,
}) async {
  return await File(
          '${Directory.current.path}/src/challenges/advent_of_code_$day/data/${type.name}_input_$day.data')
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .map<T>(lineParser)
      .toList();
}
