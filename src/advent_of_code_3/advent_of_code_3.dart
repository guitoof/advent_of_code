import 'dart:math';

int binaryToInt(String binary) {
  List<int> binaryList = binary.split('').map(int.parse).toList();
  int result = 0;
  for (var index = 0; index < binaryList.length; index++) {
    result +=
        (pow(2, index) as int) * binaryList[binaryList.length - 1 - index];
  }
  return result;
}

int getPowerConsumption({required List<List<int>> report}) {
  final sum = report.fold<List<int>>([0, 0, 0, 0, 0], (sum, entry) {
    var newSum = <int>[];
    for (var i = 0; i < sum.length; i++) {
      newSum.add(sum[i] + entry[i]);
    }
    return newSum;
  });
  final gammaRate = sum.map((e) => e > report.length / 2 ? 1 : 0);
  final epsilonRate = gammaRate.map((e) => e == 1 ? 0 : 1).toList();
  return binaryToInt(gammaRate.join()) * binaryToInt(epsilonRate.join());
}
