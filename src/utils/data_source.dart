import 'dart:convert';
import 'dart:io';

typedef Parser<T> = T Function(String line);

Future<List<T>> getInputDataFromFile<T>(
    {required String filePath, required Parser<T> parser}) async {
  return await File('${Directory.current.path}/$filePath')
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .map(parser)
      .toList();
}

Future<List<T>> getInputDataFromLocation<T>(
    {required int id,
    required String location,
    required Parser<T> parser}) async {
  return getInputDataFromFile(filePath: '$location/input_$id', parser: parser);
}

Future<List<T>> getInputData<T>(
    {required int id, required Parser<T> parser}) async {
  return getInputDataFromLocation(id: id, location: 'data', parser: parser);
}
