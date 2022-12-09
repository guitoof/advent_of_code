import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

class DailySolver3 extends DailySolver<Rucksack> with RucksackCleanPacker {
  DailySolver3({required super.day});

  @override
  Rucksack lineParser(String line) => Rucksack({
        1: line.substring(0, line.length ~/ 2),
        2: line.substring(line.length ~/ 2)
      });

  @override
  Future<void> loadInputData({required DataSourceType ofType}) async {
    await super.loadInputData(ofType: ofType);
    loadRucksack();
  }

  @override
  Future<OutputType> solve(
      {required int part,
      DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);

    return sumDuplicatesPriority();
  }
}

final _kPriorityMap = {
  ...generateIndexedAlphabeticMap(lowercase: true),
  ...generateIndexedAlphabeticMap(lowercase: false, indexOffset: 26)
};

class Rucksack {
  Map<int, String> compartments = {};

  Rucksack(this.compartments);

  Iterable<String> get duplicates {
    assert(
        compartments.length == 2 &&
            compartments[1] != null &&
            compartments[2] != null,
        'Should have 2 compartments');
    final compartment1 = compartments[1]!;
    final compartment2 = compartments[2]!;
    final duplicates = <String>[];
    for (var item in compartment1.split('')) {
      if (item.isNotEmpty && compartment2.contains(item)) {
        if (duplicates.isEmpty || !duplicates.last.contains(item)) {
          duplicates.add(item);
        }
      }
    }
    return duplicates;
  }

  int get duplicatesPrioritySum =>
      duplicates.fold(0, (sum, duplicate) => sum + _kPriorityMap[duplicate]!);

  @override
  String toString() => compartments.toString();
}

List<String> generateAlphabeticList({required bool lowercase}) {
  return List.generate(
      26,
      (index) =>
          String.fromCharCode(index + (lowercase ? 'a' : 'A').codeUnitAt(0)));
}

Map<String, int> generateIndexedAlphabeticMap(
        {required bool lowercase, int indexOffset = 0}) =>
    generateAlphabeticList(lowercase: lowercase)
        .asMap()
        .map((index, letter) => MapEntry(letter, index + 1 + indexOffset));

mixin RucksackCleanPacker on DailySolver<Rucksack> {
  List<Rucksack> _rucksacks = <Rucksack>[];

  loadRucksack() {
    _rucksacks = inputData;
  }

  Iterable<Iterable<String>> getAllDuplicates() =>
      _rucksacks.map((rucksack) => rucksack.duplicates);

  int sumDuplicatesPriority() => _rucksacks.fold(
      0, (sum, rucksack) => sum + rucksack.duplicatesPrioritySum);
}
