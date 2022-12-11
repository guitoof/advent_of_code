import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

class DailySolver4 extends DailySolver<List<List<int>>, int>
    with CampCleaningManager {
  DailySolver4({required super.day, required super.part});

  @override
  List<List<int>> lineParser(String line) => line
      .split(',')
      .map(
        (item) => item.split('-').map(int.parse).toList(),
      )
      .toList();

  @override
  Future<void> loadInputData({required DataSourceType ofType}) async {
    await super.loadInputData(ofType: ofType);
    loadCleaningAssignments();
  }

  @override
  Future<int> solve({DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);

    switch (part) {
      case 1:
        return countFullyContainedPairs;
      case 2:
        return countOverlappingPairs;
      default:
        throw Exception('Invalid part: $part');
    }
  }
}

class AssignedCleaningRange {
  final int start;
  final int end;

  AssignedCleaningRange(this.start, this.end);

  bool contains(int value) => value >= start && value <= end;

  @override
  String toString() => '[$start, $end]';
}

class CleaningPair {
  final AssignedCleaningRange range1;
  final AssignedCleaningRange range2;

  CleaningPair(this.range1, this.range2);

  bool get isFullyContained =>
      range1.contains(range2.start) && range1.contains(range2.end) ||
      range2.contains(range1.start) && range2.contains(range1.end);

  bool get isOverlapping =>
      range1.contains(range2.start) ||
      range1.contains(range2.end) ||
      range2.contains(range1.start) ||
      range2.contains(range1.end);

  @override
  String toString() => '[$range1, $range2]';
}

mixin CampCleaningManager on DailySolver<List<List<int>>, int> {
  List<CleaningPair> cleaningPairs = [];
  loadCleaningAssignments() {
    cleaningPairs = inputData
        .map(
          (pair) => CleaningPair(
            AssignedCleaningRange(pair.first.first, pair.first.last),
            AssignedCleaningRange(pair.last.first, pair.last.last),
          ),
        )
        .toList();
  }

  int get countFullyContainedPairs => cleaningPairs.fold(
      0, (count, pair) => count + (pair.isFullyContained ? 1 : 0));

  int get countOverlappingPairs => cleaningPairs.fold(
      0, (count, pair) => count + (pair.isOverlapping ? 1 : 0));
}
