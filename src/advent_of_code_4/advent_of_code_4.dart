typedef BingoBoard = List<List<BingoNumber>>;

enum BingoBoardWinningPlace { first, last }

class BingoNumber {
  final int value;
  bool marked = false;

  @override
  String toString() {
    return marked ? '(${value.toString()})' : value.toString();
  }

  BingoNumber(this.value);
}

class BingoBoardSize {
  final int width;
  final int height;

  const BingoBoardSize(this.width, this.height);
}

BingoBoard parseInputBoard(List<List<int>> inputBoard) {
  return inputBoard
      .map((line) =>
          line.map<BingoNumber>((value) => BingoNumber(value)).toList())
      .toList();
}

List<BingoBoard> _mark(List<BingoBoard> bingoBoards, int drawnNumber) {
  for (var bingoBoard in bingoBoards) {
    final boardSize = BingoBoardSize(bingoBoard[0].length, bingoBoard.length);
    for (var i = 0; i < boardSize.height; i++) {
      for (var j = 0; j < boardSize.width; j++) {
        if (bingoBoard[i][j].value == drawnNumber) {
          bingoBoard[i][j].marked = true;
        }
      }
    }
  }
  return bingoBoards;
}

bool isWinner(BingoBoard bingoBoard) {
  return _hasWinningRow(bingoBoard) || _hasWinningColumn(bingoBoard);
}

bool _hasWinningRow(BingoBoard bingoBoard) {
  final boardSize = BingoBoardSize(bingoBoard[0].length, bingoBoard.length);
  for (var i = 0; i < boardSize.height; i++) {
    var isWinningRow = true;
    for (var j = 0; j < boardSize.width; j++) {
      isWinningRow &= bingoBoard[i][j].marked;
    }
    if (isWinningRow) return true;
  }
  return false;
}

bool _hasWinningColumn(BingoBoard bingoBoard) {
  final boardSize = BingoBoardSize(bingoBoard[0].length, bingoBoard.length);
  for (var j = 0; j < boardSize.width; j++) {
    var isWinningColumn = true;
    for (var i = 0; i < boardSize.height; i++) {
      isWinningColumn &= bingoBoard[i][j].marked;
    }
    if (isWinningColumn) return true;
  }
  return false;
}

List<BingoBoard> _hasWinners(List<BingoBoard> bingoBoards) =>
    bingoBoards.where(isWinner).toList();

int getBingoBoardScore(BingoBoard bingoBoard) {
  return bingoBoard.fold(
      0,
      (prev, bingoNumber) =>
          prev +
          bingoNumber.fold(
              0,
              (prev, bingoNumber) =>
                  prev + (!bingoNumber.marked ? bingoNumber.value : 0)));
}

int getBingoScore(
    {required List<BingoBoard> bingoBoards,
    required List<int> drawnNumbers,
    BingoBoardWinningPlace which = BingoBoardWinningPlace.first}) {
  switch (which) {
    case BingoBoardWinningPlace.first:
      for (var drawnNumber in drawnNumbers) {
        _mark(bingoBoards, drawnNumber);
        final winningBoards = _hasWinners(bingoBoards);
        if (winningBoards.isNotEmpty) {
          return drawnNumber * getBingoBoardScore(winningBoards.first);
        }
      }
      break;
    case BingoBoardWinningPlace.last:
      var winningBoards = <BingoBoard>[];
      int? lastWinningDrawnNumber;
      for (var drawnNumber in drawnNumbers) {
        _mark(bingoBoards, drawnNumber);
        final newWinningBoards = _hasWinners(bingoBoards);
        if (newWinningBoards.isNotEmpty) {
          winningBoards += newWinningBoards;
          for (var wb in winningBoards) {
            bingoBoards.remove(wb);
          }
          lastWinningDrawnNumber = drawnNumber;
        }
      }
      if (lastWinningDrawnNumber == null) break;
      return lastWinningDrawnNumber * getBingoBoardScore(winningBoards.last);
  }

  throw Exception('No winning board found in: $bingoBoards');
}
