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

int countIncreasingMeasurementsByWindow(List<int> input,
    {required int windowSize}) {
  var acc = 0;
  var currentWindow = [];
  int? previousSum;
  input.asMap().forEach((int index, int value) {
    currentWindow.add(value);
    if (currentWindow.length < windowSize) {
      return;
    }
    final sum = currentWindow.reduce((s, x) => s + x);
    currentWindow.removeAt(0);

    if (previousSum == null) {
      previousSum = sum;
      return;
    }

    acc += previousSum! < sum ? 1 : 0;
    previousSum = sum;
  });
  return acc;
}

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
