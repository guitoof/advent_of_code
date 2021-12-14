typedef Input = List<dynamic>;

class Polymere {
  String sequence;
  List<String> buildingInstructions;

  Polymere({required this.sequence, required this.buildingInstructions});

  @override
  String toString() => sequence;

  void buildNextStep() {
    var _sequence = sequence.split('');
    for (var index = 0; index < _sequence.length - 1; index++) {
      final pattern = '${_sequence[index]}${_sequence[index + 1]}';
      final String? matchingBuildingInstruction = buildingInstructions
          .firstWhere((instruction) => instruction.contains(pattern));
      if (matchingBuildingInstruction == null) {
        continue;
      }
      final newElement = matchingBuildingInstruction.split(' -> ').last;
      _sequence.insert(index + 1, newElement);
      index++;
      sequence = _sequence.join();
    }
  }

  Map<String, int> get elementDistribution {
    Map<String, int> distribution = {};
    for (var element in sequence.split('')) {
      var elementDistribution = distribution[element];
      if (elementDistribution != null) {
        elementDistribution++;
      } else {
        elementDistribution = 1;
      }
      distribution[element] = elementDistribution;
    }
    return distribution;
  }

  MapEntry<String, int> get mostCommonElement => elementDistribution.entries
      .reduce((max, entry) => entry.value >= max.value ? entry : max);

  MapEntry<String, int> get leastCommonElement => elementDistribution.entries
      .reduce((min, entry) => entry.value <= min.value ? entry : min);
}

int getPolymereCompositionScore(Input input, {required int steps}) {
  final polymere = Polymere(
      sequence: input.first,
      buildingInstructions: (input.last as List<dynamic>).cast<String>());
  for (var step = 0; step < steps; step++) {
    polymere.buildNextStep();
  }
  return polymere.mostCommonElement.value - polymere.leastCommonElement.value;
}
