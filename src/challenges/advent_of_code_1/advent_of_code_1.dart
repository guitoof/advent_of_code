import 'dart:math' as math;

import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

class DailySolver1 extends DailySolver<String> with FoodPayloadCalorieManager {
  DailySolver1({required super.day});

  @override
  String lineParser(String line) => line;

  @override
  Future<void> loadInputData({required DataSourceType ofType}) async {
    await super.loadInputData(ofType: ofType);
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
  Future<OutputType> solve(
      {required int part,
      DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);
    switch (part) {
      case 0:
      case 1:
        return getMaxNumberOfCaloriesByElf();
      case 2:
        return getTotalTop3MaxNumberOfCalories();
      default:
        throw UnsupportedCase();
    }
  }
}

typedef FoodPayload = List<int>;

mixin FoodPayloadCalorieManager {
  late List<FoodPayload> foodPayloadByElf;

  Future<int> getMaxNumberOfCaloriesByElf() async {
    return foodPayloadByElf.fold<int>(0,
        (previousMax, foodPayload) => math.max(previousMax, foodPayload.sum));
  }

  List<int> getTop3MaxNumberOfCalories() {
    return foodPayloadByElf.fold<List<int>>([], (currentTop3, foodPayload) {
      if (currentTop3.length < 3) {
        currentTop3.add(foodPayload.sum);
        return currentTop3;
      }
      final currentTop4 = [...currentTop3, foodPayload.sum];
      currentTop4.remove(currentTop4.min);
      assert(currentTop4.length == 3);
      return currentTop4;
    });
  }

  Future<int> getTotalTop3MaxNumberOfCalories() async {
    return getTop3MaxNumberOfCalories().sum;
  }
}

extension FoodPayloadWithSum on FoodPayload {
  int get sum => fold(0, (total, item) => total + item);
  int get min => reduce((value, element) => math.min(value, element));
}
