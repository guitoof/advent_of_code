import 'dart:convert';
import 'dart:io';

typedef Parser<T> = T Function(String line);

Future<List<T>> getInputData<T>(
    {required int id, required Parser<T> parser}) async {
  return await File('${Directory.current.path}/data/input_$id')
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .map(parser)
      .toList();
}
