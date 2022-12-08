import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

enum RockPaperScissors {
  rock,
  paper,
  scissors;

  factory RockPaperScissors.fromStringCode(String code) {
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

  factory MatchOutcome.fromStringCode(String code) {
    switch (code) {
      case 'X':
        return MatchOutcome.lose;
      case 'Y':
        return MatchOutcome.draw;
      case 'Z':
        return MatchOutcome.win;
      default:
        throw ArgumentError(
          'Unsupported string code: $code, to parse $MatchOutcome',
        );
    }
  }

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

  factory RockPaperScissorsMatch.fromOutcome(
      {required opponent, required MatchOutcome outcome}) {
    late RockPaperScissors player;
    switch (opponent) {
      case RockPaperScissors.rock:
        switch (outcome) {
          case MatchOutcome.win:
            player = RockPaperScissors.paper;
            break;
          case MatchOutcome.draw:
            player = RockPaperScissors.rock;
            break;
          case MatchOutcome.lose:
            player = RockPaperScissors.scissors;
            break;
        }
        break;
      case RockPaperScissors.paper:
        switch (outcome) {
          case MatchOutcome.win:
            player = RockPaperScissors.scissors;
            break;
          case MatchOutcome.draw:
            player = RockPaperScissors.paper;
            break;
          case MatchOutcome.lose:
            player = RockPaperScissors.rock;
            break;
        }
        break;
      case RockPaperScissors.scissors:
        switch (outcome) {
          case MatchOutcome.win:
            player = RockPaperScissors.rock;
            break;
          case MatchOutcome.draw:
            player = RockPaperScissors.scissors;
            break;
          case MatchOutcome.lose:
            player = RockPaperScissors.paper;
            break;
        }
        break;
    }
    return RockPaperScissorsMatch(player: player, opponent: opponent);
  }

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

class DailySolver2 extends DailySolver<List<String>>
    with RockPaperScissorsGameManager {
  DailySolver2({required super.day});

  @override
  List<String> lineParser(String line) => line.split(' ').toList();

  @override
  Future<void> loadInputData({required DataSourceType ofType}) async {
    await super.loadInputData(ofType: ofType);
  }

  @override
  Future<OutputType> solve(
      {required int part,
      DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);

    switch (part) {
      case 1:
        loadMatchesFromHands();
        break;
      case 2:
        loadMatchesFromHandAndOutcome();
        break;
      default:
        throw ArgumentError('Unsupported part: $part');
    }

    return getRockPaperScissorsScore();
  }
}

mixin RockPaperScissorsGameManager on DailySolver<List<String>> {
  List<RockPaperScissorsMatch> _matches = [];

  void loadMatchesFromHands() {
    _matches = (inputData).map((items) {
      final hands = items.map(RockPaperScissors.fromStringCode).toList();
      return RockPaperScissorsMatch(
        player: hands.last,
        opponent: hands.first,
      );
    }).toList();
  }

  void loadMatchesFromHandAndOutcome() {
    _matches = (inputData).map((items) {
      final hand = RockPaperScissors.fromStringCode(items.first);
      final outcome = MatchOutcome.fromStringCode(items.last);
      return RockPaperScissorsMatch.fromOutcome(
        opponent: hand,
        outcome: outcome,
      );
    }).toList();
  }

  List<int> getScoreByMatch() => _matches.map((match) => match.score).toList();

  int getRockPaperScissorsScore() {
    return _matches.fold<int>(0, (total, match) => total + match.score);
  }
}
