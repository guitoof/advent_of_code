import '../../utils/daily_solver.dart';

class DailySolver0 extends DailySolver<String>
    with SomeMixinWithChallengeLogic {
  DailySolver0({required super.day, required super.name});

  @override
  String lineParser(String line) => line; // CHANGE HERE

  @override
  Future<void> loadInputData({required int part}) async {
    await super.loadInputData(part: part);

    /// LOAD & FORMAT YOUR DATA HERE
  }

  @override
  Future<OutputType> solve({required int part}) async {
    await loadInputData(part: part);

    /// ACTUALLY SOLVE THE CHALLENGE HERE

    return -1;
  }
}

mixin SomeMixinWithChallengeLogic {}
