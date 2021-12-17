typedef Input = List<dynamic>;

enum PolymereGenerationMethod { basic, scalable }

class Polymere {
  String sequence;
  late final Map<String, String> _buildingInstructions;
  late Map<String, int> pairDistributions;

  Polymere(
      {required this.sequence, required List<String> buildingInstructions}) {
    _buildingInstructions = {
      for (var instruction in buildingInstructions)
        instruction.split(' -> ')[0]: instruction.split(' -> ')[1]
    };
    pairDistributions = {
      for (var instruction in buildingInstructions)
        instruction.split(' -> ')[0]:
            instruction.split(' -> ')[0].allMatches(sequence).length,
    };
  }

  @override
  String toString() => sequence;

  String getMatchingBuildingInstruction(String pattern) =>
      _buildingInstructions[pattern]!;

  List<String> getChildrenFromPattern(String pattern) {
    final splitPattern = pattern.split('');
    return [
      '${splitPattern.first}${getMatchingBuildingInstruction(pattern)}',
      '${getMatchingBuildingInstruction(pattern)}${splitPattern.last}',
    ];
  }

  void updatePairDistributionForNextStep() {
    final updates = Map.fromIterables(pairDistributions.keys,
        List.generate(pairDistributions.length, (_) => 0));
    for (var pairDistribution
        in pairDistributions.entries.where((entry) => entry.value > 0)) {
      updates[pairDistribution.key] =
          updates[pairDistribution.key]! - pairDistribution.value;
      for (var child in getChildrenFromPattern(pairDistribution.key)) {
        updates[child] = updates[child]! + pairDistribution.value;
      }
    }
    for (var update in updates.entries) {
      pairDistributions[update.key] =
          pairDistributions[update.key]! + update.value;
    }
  }

  Map<String, int> getElementDistribution() {
    Map<String, int> elementDistribution = {};
    for (var pairDistribution in pairDistributions.entries) {
      for (var element in pairDistribution.key.split('')) {
        if (elementDistribution[element] != null) {
          elementDistribution[element] =
              elementDistribution[element]! + pairDistribution.value;
        } else {
          elementDistribution[element] = pairDistribution.value;
        }
      }
    }
    final firstElement = sequence.split('').first;
    final lastElement = sequence.split('').last;
    return elementDistribution.map<String, int>((key, value) => MapEntry(key,
        (value ~/ 2) + (key == firstElement || key == lastElement ? 1 : 0)));
  }

  MapEntry<String, int> get mostCommonElement => getElementDistribution()
      .entries
      .reduce((max, entry) => entry.value >= max.value ? entry : max);

  MapEntry<String, int> get leastCommonElement => getElementDistribution()
      .entries
      .reduce((min, entry) => entry.value < min.value ? entry : min);
}

int getPolymereCompositionScore(Input input, {required int steps}) {
  final polymere = Polymere(
      sequence: input.first,
      buildingInstructions: (input.last as List<dynamic>).cast<String>());
  for (var step = 1; step <= steps; step++) {
    polymere.updatePairDistributionForNextStep();
  }
  return polymere.mostCommonElement.value - polymere.leastCommonElement.value;
}
