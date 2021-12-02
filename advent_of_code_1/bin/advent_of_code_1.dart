import 'dart:convert';
import 'dart:io';

int countIncreasingMeasurements(List<int> input) {
  var acc = 0;
  input.asMap().forEach((int index, int value) {
    if (index == 0) {
      return;
    }
    acc += input[index - 1] < input[index] ? 1 : 0;
  });
  return acc;
}

void main(List<String> arguments) async {
  final input = await File('../data/input')
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .map((item) => int.parse(item))
      .toList();
  print(countIncreasingMeasurements(input));
}
