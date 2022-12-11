import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

class DailySolver{{ day }} extends DailySolver<String>
    with SomeMixinWithChallengeLogic {
  DailySolver{{ day }}({required super.day, required super.part});

  @override
  String lineParser(String line) => line; // CHANGE HERE

  @override
  Future<void> loadInputData({required DataSourceType ofType}) async {
    await super.loadInputData(ofType: ofType);

    /// LOAD & FORMAT YOUR DATA HERE
  }

  @override
  Future<OutputType> solve(
      {required int part,
      DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);

    /// ACTUALLY SOLVE THE CHALLENGE HERE

    return -1;
  }
}

mixin SomeMixinWithChallengeLogic {}
