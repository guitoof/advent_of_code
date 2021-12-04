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

List<int> getMostCommon({required List<List<int>> report}) {
  final sum = report.fold<List<int>>(List.generate(report[0].length, (_) => 0),
      (sum, entry) {
    var newSum = <int>[];
    for (var i = 0; i < sum.length; i++) {
      newSum.add(sum[i] + entry[i]);
    }
    return newSum;
  });
  return sum.map((e) => e >= report.length / 2 ? 1 : 0).toList();
}

List<int> getLeastCommon({required List<List<int>> report}) {
  return getMostCommon(report: report).map((e) => e == 1 ? 0 : 1).toList();
}

int getPowerConsumption({required List<List<int>> report}) {
  final gammaRateReport = getMostCommon(report: report);
  final epsilonRateReport = getLeastCommon(report: report);
  return binaryToInt(gammaRateReport.join()) *
      binaryToInt(epsilonRateReport.join());
}

List<int> getGenericRatingReport(
    {required List<List<int>> report,
    required List<int> Function({required List<List<int>> report})
        refReportBuilder}) {
  var output = report;
  var counter = 0;
  while (output.length != 1) {
    output = output.where((line) {
      final refReport = refReportBuilder(report: output);
      return line[counter] == refReport[counter];
    }).toList();
    counter++;
  }
  return output.first;
}

List<int> getOxygenGeneratorRatingReport({required List<List<int>> report}) =>
    getGenericRatingReport(report: report, refReportBuilder: getMostCommon);

List<int> getCO2ScrubberRatingReport({required List<List<int>> report}) =>
    getGenericRatingReport(report: report, refReportBuilder: getLeastCommon);

int getLifeSupportRating({required List<List<int>> report}) {
  final oxygenGeneratorRatingReport =
      getOxygenGeneratorRatingReport(report: report);
  final c02ScrubberRatingReport = getCO2ScrubberRatingReport(report: report);
  final oxygenGeneratorRating = binaryToInt(oxygenGeneratorRatingReport.join());
  final c02ScrubberRating = binaryToInt(c02ScrubberRatingReport.join());
  return oxygenGeneratorRating * c02ScrubberRating;
}
