import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../src/advent_of_code_14/advent_of_code_14.dart';
import '../../src/advent_of_code_14/data_source.dart';
import '../../src/utils/data_source.dart' hide getInputData;

Future<List<dynamic>> getInputData() async {
  final rawData =
      (await getTestInputData<dynamic>(id: 14, parser: input14Parser))
          .where((line) => line != '')
          .toList();
  return [rawData.first, rawData.where((line) => line.contains('->')).toList()];
}

void main() {
  group('Polymere', () {
    group('updatePairDistributionForNextStep', () {
      test('should return the distribution of element pairs after 1 step',
          () async {
        final input = await getInputData();
        final polymere = Polymere(
            sequence: input.first,
            buildingInstructions: (input.last as List<dynamic>).cast<String>());
        polymere.updatePairDistributionForNextStep();
        expect(
            polymere.pairDistributions.values
                .fold<int>(0, (sum, value) => sum + value),
            6);
        expect(
            polymere.pairDistributions,
            equals({
              'CH': 1,
              'HH': 0,
              'CB': 0,
              'NH': 0,
              'HB': 1,
              'HC': 0,
              'HN': 0,
              'NN': 0,
              'BH': 0,
              'NC': 1,
              'NB': 1,
              'BN': 0,
              'BB': 0,
              'BC': 1,
              'CC': 0,
              'CN': 1,
            }));
      });
      test(
          'should return a new pair distribution with twice as many pairs after 1 step',
          () async {
        final input = await getInputData();
        final polymere = Polymere(
            sequence: input.first,
            buildingInstructions: (input.last as List<dynamic>).cast<String>());
        polymere.updatePairDistributionForNextStep();
        polymere.updatePairDistributionForNextStep();
        expect(
            polymere.pairDistributions.values
                .fold<int>(0, (sum, value) => sum + value),
            12);
      });

      test(
          'should return a new pair distribution with x3 as many pairs after 2 steps',
          () async {
        final input = await getInputData();
        final polymere = Polymere(
            sequence: input.first,
            buildingInstructions: (input.last as List<dynamic>).cast<String>());
        for (var step = 1; step <= 3; step++) {
          polymere.updatePairDistributionForNextStep();
        }
        expect(
            polymere.pairDistributions.values
                .fold<int>(0, (sum, value) => sum + value),
            24);
      });
    });
  });

  group('getPolymereCompositionScore', () {
    test(
        'should return the difference between the most & least common element in the produced polymere after 10 steps',
        () async {
      final input = await getInputData();
      expect(getPolymereCompositionScore(input, steps: 10), 1588);
    });
    test(
        'should return the difference between the most & least common element in the produced polymere after 40 steps',
        () async {
      final input = await getInputData();
      expect(getPolymereCompositionScore(input, steps: 40), 2188189693529);
    });
  });
}
