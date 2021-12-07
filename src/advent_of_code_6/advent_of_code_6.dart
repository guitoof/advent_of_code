class FishSchool {
  List<int> fishes;
  List<int> youngFishes = [];
  static int fishChildhoodDuration = 8;
  static int fishProcreactionDuration = 6;

  int get size => fishes.length + youngFishes.length;

  FishSchool({required this.fishes});

  void spendDay() {
    List<int> newBornFishes = <int>[];
    fishes = fishes.map((fish) {
      if (fish == 0) {
        newBornFishes.add(fishChildhoodDuration);
        return fishProcreactionDuration;
      }
      return fish - 1;
    }).toList();
    youngFishes = youngFishes.map((fish) {
      if (fish == 0) {
        newBornFishes.add(fishChildhoodDuration);
        fishes.add(fishProcreactionDuration);
      }
      return fish - 1;
    }).toList();
    youngFishes.removeWhere((fish) => fish == -1);
    youngFishes += newBornFishes;
  }
}

int simulateLanternFishProduction(List<int> input, {required int days}) {
  final school = FishSchool(fishes: input);
  for (var day = 1; day <= days; day++) {
    school.spendDay();
  }
  return school.size;
}

class SmartFishSchool {
  final List<int> fishesCalendar = List.generate(9, (_) => 0);

  SmartFishSchool({required List<int> fishAges}) {
    for (var fishAge in fishAges) {
      fishesCalendar[fishAge]++;
    }
  }

  int get size => fishesCalendar.fold(0, (result, value) => result + value);

  void spendDay() {
    final numberOfCarryingFishes = fishesCalendar.removeAt(0);

    /// Reset new parents to the 7th position
    fishesCalendar[6] += numberOfCarryingFishes;

    /// Add new borns to the 9th position
    fishesCalendar.add(numberOfCarryingFishes);

    assert(fishesCalendar.length == 9);
  }
}

int simulateOptimizedLanternFishProduction(List<int> input,
    {required int days}) {
  final school = SmartFishSchool(fishAges: input);
  for (var day = 1; day <= days; day++) {
    school.spendDay();
  }
  return school.size;
}
