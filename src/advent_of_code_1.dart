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
