int getFuelConsumption(List<int> input) {
  List<int> data = [...input];
  data.sort();
  final left = data.sublist(0, data.length ~/ 2);
  final right = data.sublist(data.length ~/ 2, data.length);
  print(left);
  print(right);
  int median = (left.last + right.first) ~/ 2;
  return input.fold(0, (result, value) => result + (value - median).abs());
}
