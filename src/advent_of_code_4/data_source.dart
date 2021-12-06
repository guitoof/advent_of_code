import '../utils/data_source.dart';

class Input4Data {
  final List<int> drawnNumbers;
  final List<List<List<int>>> bingoBoards;

  Input4Data({required this.drawnNumbers, required this.bingoBoards});
}

Future<Input4Data> getInput4Data() async {
  final input = await getInputData<String>(id: 4, parser: (line) => line);
  final drawnNumbers = input[0].split(',').map(int.parse).toList();
  input.removeAt(0);
  List<List<List<int>>> bingoBoards = [];
  var newBingoBoard = <List<int>>[];
  for (var line in input) {
    if (line == "") {
      if (newBingoBoard.isNotEmpty) {
        bingoBoards.add(newBingoBoard);
      }
      newBingoBoard = <List<int>>[];
    } else {
      newBingoBoard.add(line
          .split(' ')
          .where((element) => element.isNotEmpty)
          .map(int.parse)
          .toList());
    }
  }
  return Input4Data(drawnNumbers: drawnNumbers, bingoBoards: bingoBoards);
}
