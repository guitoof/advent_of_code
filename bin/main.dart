import 'dart:convert';
import 'dart:io';

import 'advent_of_code_1.dart';

void main(List<String> arguments) async {
  final input = await File('${Directory.current.path}/data/input')
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .map((item) => int.parse(item))
      .toList();
  print('Part 1 : ${countIncreasingMeasurements(input)}');
  print(
      'Part 2 : ${countIncreasingMeasurementsByWindow(input, windowSize: 3)}');
}
