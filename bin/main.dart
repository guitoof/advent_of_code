import 'dart:convert';
import 'dart:io';

import '../src/advent_of_code_x.dart';

void main(List<String> arguments) async {
  final input = await File('${Directory.current.path}/data/input')
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .map((item) => int.parse(item))
      .toList();
  print('The answer is: ${myFunction()}');
}
