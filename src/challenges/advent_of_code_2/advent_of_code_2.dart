import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

enum RockPaperScissors {
  rock,
  paper,
  scissors;

  static RockPaperScissors fromStringCode(String code) {
    switch (code) {
      case 'A':
      case 'X':
        return RockPaperScissors.rock;
      case 'B':
      case 'Y':
        return RockPaperScissors.paper;
      case 'C':
      case 'Z':
        return RockPaperScissors.scissors;
      default:
        throw ArgumentError(
          'Unsupported string code: $code, to parse $RockPaperScissors',
        );
    }
  }

  int get score {
    switch (this) {
      case RockPaperScissors.rock:
        return 1;
      case RockPaperScissors.paper:
        return 2;
      case RockPaperScissors.scissors:
        return 3;
    }
  }
}

enum MatchOutcome {
  win,
  lose,
  draw;

  int get score {
    switch (this) {
      case MatchOutcome.win:
        return 6;
      case MatchOutcome.lose:
        return 0;
      case MatchOutcome.draw:
        return 3;
    }
  }
}

class RockPaperScissorsMatch {
  final RockPaperScissors player;
  final RockPaperScissors opponent;

  RockPaperScissorsMatch({
    required this.player,
    required this.opponent,
  });

  MatchOutcome get outcome {
    if (player == opponent) {
      return MatchOutcome.draw;
    }
    if (player == RockPaperScissors.rock) {
      return opponent == RockPaperScissors.scissors
          ? MatchOutcome.win
          : MatchOutcome.lose;
    }
    if (player == RockPaperScissors.paper) {
      return opponent == RockPaperScissors.rock
          ? MatchOutcome.win
          : MatchOutcome.lose;
    }
    if (player == RockPaperScissors.scissors) {
      return opponent == RockPaperScissors.paper
          ? MatchOutcome.win
          : MatchOutcome.lose;
    }
    throw StateError('Unexpected Outcome for: [$player vs $opponent]');
  }

  int get score => outcome.score + player.score;

  @override
  String toString() => '[$player vs $opponent]: $outcome';
}

class DailySolver2 extends DailySolver<List<RockPaperScissors>>
    with RockPaperScissorsGameManager {
  DailySolver2({required super.day});

  @override
  List<RockPaperScissors> lineParser(String line) =>
      line.split(' ').map(RockPaperScissors.fromStringCode).toList();

  @override
  Future<void> loadInputData({required DataSourceType ofType}) async {
    await super.loadInputData(ofType: ofType);
  }

  @override
  Future<OutputType> solve(
      {required int part,
      DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);
    return getRockPaperScissorsScore();
  }
}

mixin RockPaperScissorsGameManager on DailySolver<List<RockPaperScissors>> {
  int getRockPaperScissorsScore() {
    final matches = (inputData as List<List<RockPaperScissors>>)
        .map((hands) =>
            RockPaperScissorsMatch(player: hands.last, opponent: hands.first))
        .toList();
    return matches.fold<int>(0, (total, match) => total + match.score);
  }
}
