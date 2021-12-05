import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../src/advent_of_code_4/advent_of_code_4.dart';

void main() {
  group('isWinner', () {
    test('should return true if the board has a row with all marked numbers',
        () {
      final bingoBoard = parseInputBoard([
        [22, 13, 17, 11, 0],
        [8, 2, 23, 4, 24],
        [21, 9, 14, 16, 7],
        [6, 10, 3, 18, 5],
        [1, 12, 20, 15, 19],
      ]);
      int winningRow = 3;
      bingoBoard[winningRow].map((bingoNumber) {
        bingoNumber.marked = true;
        return bingoNumber;
      }).toList();
      print(bingoBoard);
      expect(isWinner(bingoBoard), true);
    });

    test('should return true if the board has a column with all marked numbers',
        () {
      final bingoBoard = parseInputBoard([
        [22, 13, 17, 11, 0],
        [8, 2, 23, 4, 24],
        [21, 9, 14, 16, 7],
        [6, 10, 3, 18, 5],
        [1, 12, 20, 15, 19],
      ]);
      int winningColumn = 1;
      bingoBoard.map((row) {
        final bingoNumber = row[winningColumn];
        bingoNumber.marked = true;
        return bingoNumber;
      }).toList();
      expect(isWinner(bingoBoard), true);
    });

    test(
        'should return false if the board has no column/row with all marked numbers',
        () {
      final bingoBoard = parseInputBoard([
        [22, 13, 17, 11, 0],
        [8, 2, 23, 4, 24],
        [21, 9, 14, 16, 7],
        [6, 10, 3, 18, 5],
        [1, 12, 20, 15, 19],
      ]);
      bingoBoard[0][3].marked = true;
      bingoBoard[2][0].marked = true;
      bingoBoard[2][2].marked = true;
      bingoBoard[3][1].marked = true;
      expect(isWinner(bingoBoard), false);
    });
  });

  group('getBingoBoardScore', () {
    test('should return the sum of all unmarked numbers of the given board',
        () {
      final bingoBoard = parseInputBoard(
        [
          [3, 15, 0, 2, 22],
          [9, 18, 13, 17, 5],
          [19, 8, 7, 25, 23],
          [20, 11, 10, 24, 4],
          [14, 21, 16, 12, 6],
        ],
      );
      bingoBoard[0][2].marked = true;
      bingoBoard[0][3].marked = true;
      bingoBoard[0][4].marked = true;
      bingoBoard[1][1].marked = true;
      bingoBoard[1][3].marked = true;
      bingoBoard[2][0].marked = true;
      bingoBoard[3][1].marked = true;
      bingoBoard[3][3].marked = true;
      bingoBoard[3][4].marked = true;
      const expectedScore = 3 +
          15 +
          9 +
          13 +
          5 +
          8 +
          7 +
          25 +
          23 +
          20 +
          10 +
          14 +
          21 +
          16 +
          12 +
          6;
      expect(getBingoBoardScore(bingoBoard), expectedScore);
    });
  });

  group('getBingoScore', () {
    test('should return the score of the winning bingo board', () {
      const drawnNumbers = [
        7,
        4,
        9,
        5,
        11,
        17,
        23,
        2,
        0,
        14,
        21,
        24,
        10,
        16,
        13,
        6,
        15,
        25,
        12,
        22,
        18,
        20,
        8,
        19,
        3,
        26,
        1,
      ];
      const List<List<List<int>>> bingoBoards = [
        [
          [22, 13, 17, 11, 0],
          [8, 2, 23, 4, 24],
          [21, 9, 14, 16, 7],
          [6, 10, 3, 18, 5],
          [1, 12, 20, 15, 19],
        ],
        [
          [3, 15, 0, 2, 22],
          [9, 18, 13, 17, 5],
          [19, 8, 7, 25, 23],
          [20, 11, 10, 24, 4],
          [14, 21, 16, 12, 6],
        ],
        [
          [14, 21, 17, 24, 4],
          [10, 16, 15, 9, 19],
          [18, 8, 23, 26, 20],
          [22, 11, 13, 6, 5],
          [2, 0, 12, 3, 7],
        ]
      ];
      expect(
          getBingoScore(
              bingoBoards:
                  bingoBoards.map<BingoBoard>(parseInputBoard).toList(),
              drawnNumbers: drawnNumbers),
          4512);
    });
  });
}
