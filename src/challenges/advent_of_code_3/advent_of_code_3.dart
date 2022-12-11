import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

class DailySolver3 extends DailySolver<Rucksack, int> with RucksackCleanPacker {
  DailySolver3({required super.day, required super.part});

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
  Future<int> solve({DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);
    switch (part) {
      case 1:
        return sumDuplicatesPriority();
      case 2:
        return sumBadgesPriority();
      default:
        throw Exception('Invalid part: $part');
    }
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

  List<String> get items => fullContent.split('');

  String get fullContent => compartments.values.join();

  @override
  String toString() => fullContent.toString();
}

class RucksackGroup {
  final List<Rucksack> rucksacks;
  RucksackGroup({required this.rucksacks});

  void addRucksack(Rucksack rucksack) => rucksacks.add(rucksack);

  int get size => rucksacks.length;

  String get badge {
    final badgeCandidates = rucksacks.first.items;
    for (var rucksack in rucksacks.skip(1)) {
      for (var candidate in List.from(badgeCandidates)) {
        if (!rucksack.items.contains(candidate)) {
          badgeCandidates.remove(candidate);
        }
      }
    }
    // Remove duplicates
    final foundBadges = badgeCandidates.toSet().toList();
    if (foundBadges.isEmpty) {
      throw Exception('No badge found for group: $this');
    }
    if (foundBadges.length > 1) {
      throw Exception(
        'Multiple badges (${foundBadges.length}) found for group: $this'
        ' - found badges are are: $foundBadges',
      );
    }
    return foundBadges.first;
  }

  @override
  String toString() {
    return rucksacks.map((rucksack) => rucksack.toString()).join(', ');
  }
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

mixin RucksackCleanPacker on DailySolver<Rucksack, int> {
  List<Rucksack> _rucksacks = <Rucksack>[];
  loadRucksack() {
    _rucksacks = inputData;
  }

  /// Part 1

  Iterable<Iterable<String>> getAllDuplicates() =>
      _rucksacks.map((rucksack) => rucksack.duplicates);

  int sumDuplicatesPriority() => _rucksacks.fold(
      0, (sum, rucksack) => sum + rucksack.duplicatesPrioritySum);

  /// Part 2
  List<RucksackGroup> getRucksacksByGroup({int groupSize = 3}) =>
      _rucksacks.fold<List<RucksackGroup>>([], (groups, rucksack) {
        if (groups.isEmpty || groups.last.size == groupSize) {
          return groups..add(RucksackGroup(rucksacks: [rucksack]));
        }
        return groups..last.addRucksack(rucksack);
      });

  List<List<String>> getRucksacksContentByGroup({int groupSize = 3}) =>
      getRucksacksByGroup(groupSize: groupSize)
          .map((group) =>
              group.rucksacks.map((rucksack) => rucksack.fullContent).toList())
          .toList();

  List<String> getBadgesByGroup({int groupSize = 3}) =>
      getRucksacksByGroup(groupSize: groupSize)
          .map((group) => group.badge)
          .toList();

  List<int> getBadgePrioritiesByGroup({int groupSize = 3}) =>
      getBadgesByGroup(groupSize: groupSize)
          .map((badge) => _kPriorityMap[badge]!)
          .toList();

  int sumBadgesPriority() =>
      getBadgesByGroup().fold(0, (sum, badge) => sum + _kPriorityMap[badge]!);
}
