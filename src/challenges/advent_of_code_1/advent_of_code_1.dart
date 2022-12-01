import 'dart:math';

import '../../utils/daily_solver.dart';

class DailySolver1 extends DailySolver<String> with FoodPayloadCalorieManager {
  DailySolver1({required super.day, required super.name});

  @override
  String lineParser(String line) => line;

  @override
  Future<void> loadInputData({required int part}) async {
    await super.loadInputData(part: part);
    foodPayloadByElf =
        inputData.fold<List<FoodPayload>>([[]], (previousValue, line) {
      if (line.isEmpty) {
        previousValue.add(<int>[]);
      } else {
        previousValue.last.add(int.parse(line));
      }
      return previousValue;
    });
  }

  @override
  Future<OutputType> solve({required int part}) async {
    await loadInputData(part: part);
    return getMaxNumberOfCaloriesByElf();
  }
}

typedef FoodPayload = List<int>;

mixin FoodPayloadCalorieManager {
  late List<FoodPayload> foodPayloadByElf;

  Future<int> getMaxNumberOfCaloriesByElf() async {
    return foodPayloadByElf.fold<int>(
        0, (previousMax, foodPayload) => max(previousMax, foodPayload.sum));
  }
}

extension FoodPayloadWithSum on FoodPayload {
  int get sum => fold(0, (total, item) => total + item);
}
