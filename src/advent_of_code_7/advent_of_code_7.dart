import 'dart:math';

int getFuelConsumption(List<int> input) {
  List<int> data = [...input];
  data.sort();
  final left = data.sublist(0, data.length ~/ 2);
  final right = data.sublist(data.length ~/ 2, data.length);
  int median = (left.last + right.first) ~/ 2;
  return input.fold(0, (result, value) => result + (value - median).abs());
}

int getDynamicFuelConsumption(List<int> input) {
  /// Any way to make this "mean" base approach work ?
  // int mean =
  //     (input.fold<int>(0, (result, value) => result + value) ~/ input.length);
  // return input.fold(0, (result, value) {
  //   var n = (value - mean).abs();
  //   return (result + (n * (n + 1) ~/ 2));
  // });
  return List.generate(input.reduce(max), (index) => index).reduce((a, b) {
    if (a == 0) {
      return input.fold<int>(0, (fuelConsumption, subPosition) {
        var dist = (subPosition).abs();
        return (fuelConsumption + (dist * (dist + 1) ~/ 2));
      });
    }
    return min(
        a,
        input.fold<int>(0, (fuelConsumption, subPosition) {
          var dist = (subPosition - b).abs();
          return (fuelConsumption + (dist * (dist + 1) ~/ 2));
        }));
  });
}
