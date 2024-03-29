import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

class DailySolver8 extends DailySolver<List<int>, int> with ForestMap {
  DailySolver8({required super.day, required super.part});

  @override
  List<int> lineParser(String line) =>
      line.split('').map(int.parse).toList(); // CHANGE HERE

  @override
  Future<void> loadInputData({required DataSourceType ofType}) async {
    await super.loadInputData(ofType: ofType);

    forestMap = inputData;
  }

  @override
  Future<int> solve({DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);
    switch (part) {
      case 1:
        return countVisibleTrees();
      case 2:
        return getBestScenicScore();
      default:
        throw Exception('Unsupported part: $part');
    }
  }
}

mixin ForestMap {
  late List<List<int>> forestMap;

  bool isTreeVisibleFromLeft(int row, int col) {
    // if 1 of the tree to the left is taller than the tree at [row][col]
    for (var x = col - 1; x >= 0; x--) {
      if (forestMap[row][x] >= forestMap[row][col]) {
        return false;
      }
    }
    return true;
  }

  bool isTreeVisibleFromRight(int row, int col) {
    // if 1 of the tree to the right is taller than the tree at [row][col]
    for (var x = col + 1; x <= forestMap.first.length - 1; x++) {
      if (forestMap[row][x] >= forestMap[row][col]) {
        return false;
      }
    }
    return true;
  }

  bool isTreeVisibleFromUp(int row, int col) {
    // if 1 of the tree upward is taller than the tree at [row][col]
    for (var y = row - 1; y >= 0; y--) {
      if (forestMap[y][col] >= forestMap[row][col]) {
        return false;
      }
    }
    return true;
  }

  bool isTreeVisibleFromDown(int row, int col) {
    // if 1 of the tree downward is taller than the tree at [row][col]
    for (var y = row + 1; y <= forestMap.length - 1; y++) {
      if (forestMap[y][col] >= forestMap[row][col]) {
        return false;
      }
    }
    return true;
  }

  int countVisibleTrees() {
    int count = 0;
    for (var x = 1; x < forestMap.first.length - 1; x++) {
      for (var y = 1; y < forestMap.length - 1; y++) {
        if (isTreeVisibleFromLeft(y, x) ||
            isTreeVisibleFromRight(y, x) ||
            isTreeVisibleFromUp(y, x) ||
            isTreeVisibleFromDown(y, x)) {
          count++;
        } else {}
      }
    }
    final perimeter = 2 * (forestMap.first.length + forestMap.length - 2);
    return count + perimeter;
  }

  int getViewingDistanceLeft(int row, int col) {
    int distance = 0;
    for (var x = col - 1; x >= 0; x--) {
      if (forestMap[row][x] >= forestMap[row][col]) {
        return ++distance;
      }
      distance++;
    }
    return distance;
  }

  int getViewingDistanceRight(int row, int col) {
    int distance = 0;
    for (var x = col + 1; x <= forestMap.first.length - 1; x++) {
      if (forestMap[row][x] >= forestMap[row][col]) {
        return ++distance;
      }
      distance++;
    }
    return distance;
  }

  int getViewingDistanceUp(int row, int col) {
    int distance = 0;
    for (var y = row - 1; y >= 0; y--) {
      if (forestMap[y][col] >= forestMap[row][col]) {
        return ++distance;
      }
      distance++;
    }
    return distance;
  }

  int getViewingDistanceDown(int row, int col) {
    int distance = 0;
    for (var y = row + 1; y <= forestMap.length - 1; y++) {
      if (forestMap[y][col] >= forestMap[row][col]) {
        return ++distance;
      }
      distance++;
    }
    return distance;
  }

  int getScenicScore(int row, int col) =>
      getViewingDistanceLeft(row, col) *
      getViewingDistanceRight(row, col) *
      getViewingDistanceUp(row, col) *
      getViewingDistanceDown(row, col);

  int getBestScenicScore() {
    int bestScore = 0;
    for (var x = 1; x < forestMap.first.length - 1; x++) {
      for (var y = 1; y < forestMap.length - 1; y++) {
        final score = getScenicScore(y, x);
        if (score > bestScore) {
          bestScore = score;
        }
      }
    }
    return bestScore;
  }
}
