import 'dart:convert';
import 'dart:io';

Future<List<int>> getInputData({required int id}) async {
  return await File('${Directory.current.path}/data/input_$id')
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .map((item) => int.parse(item))
      .toList();
}
