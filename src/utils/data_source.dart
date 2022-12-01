import 'dart:convert';
import 'dart:io';

Future<List<T>> getInputData<T>({
  required int day,
  required int part,
  required T Function(String) lineParser,
}) async {
  assert(part == 0 || part == 1 || part == 2);
  return await File(
          '${Directory.current.path}/src/challenges/advent_of_code_$day/data/input_${day}_$part')
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .map<T>(lineParser)
      .toList();
}
