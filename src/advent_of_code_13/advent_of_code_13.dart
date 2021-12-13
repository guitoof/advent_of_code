import 'dart:math';

typedef Input = List<List<dynamic>>;
typedef DotsPositionInput = List<List<int>>;
typedef FoldingInstructions = List<String>;

enum FoldingAxis { x, y }

class TransparentPaper {
  late List<List<bool>> _dots;
  late int initialWidth;
  late int intialHeight;

  TransparentPaper.fromInput(DotsPositionInput dotsPosition) {
    initialWidth =
        dotsPosition.fold<int>(0, (value, point) => max(value, point[0])) + 1;
    intialHeight =
        dotsPosition.fold<int>(0, (value, point) => max(value, point[1])) + 1;
    _dots = List<List<bool>>.generate(
      intialHeight,
      (y) => List<bool>.generate(initialWidth, (x) {
        try {
          return dotsPosition
              .firstWhere((dot) => dot[0] == x && dot[1] == y)
              .isNotEmpty;
        } catch (e) {
          return false;
        }
      }),
    );
  }

  @override
  String toString() => _dots
      .map((line) => line.map((dot) => dot ? '#' : '.').join(' '))
      .toList()
      .join('\n');

  void fold({required FoldingAxis axis, required int value}) {
    int width = _dots[0].length;
    int height = _dots.length;

    if (axis == FoldingAxis.x) assert(value < width);
    if (axis == FoldingAxis.y) assert(value < height);

    switch (axis) {
      case FoldingAxis.x:
        for (var x = 0; x < width - value; x++) {
          for (var y = 0; y < height; y++) {
            _dots[y][value - x] = _dots[y][value - x] || _dots[y][value + x];
          }
        }
        for (var line in _dots) {
          line.removeRange(value, width);
        }
        break;
      case FoldingAxis.y:
        for (var y = 0; y < height - value; y++) {
          for (var x = 0; x < width; x++) {
            _dots[value - y][x] = _dots[value - y][x] || _dots[value + y][x];
          }
        }
        _dots.removeRange(value, height);
        break;
    }
  }

  int get countVisibleDots => _dots.fold(0,
      (count, line) => line.fold(count, (count, dot) => count + (dot ? 1 : 0)));
}

int countVisibleDotsAfterFoldingOnce(Input input) {
  final paper = TransparentPaper.fromInput(input[0] as DotsPositionInput);
  final foldingInstruction = (input[1] as FoldingInstructions).first;
  final foldingAxis = FoldingAxis.values.firstWhere((e) =>
      e.toString() ==
      'FoldingAxis.${foldingInstruction.split('=').first.split(' ').last}');
  final foldingValue = int.parse(foldingInstruction.split('=').last);
  paper.fold(axis: foldingAxis, value: foldingValue);
  return paper.countVisibleDots;
}

TransparentPaper getVisibleDotsAfterCompleteFolding(Input input) {
  final paper = TransparentPaper.fromInput(input[0] as DotsPositionInput);
  final foldingInstructions = (input[1] as FoldingInstructions);
  for (var foldingInstruction in foldingInstructions) {
    final foldingAxis = FoldingAxis.values.firstWhere((e) =>
        e.toString() ==
        'FoldingAxis.${foldingInstruction.split('=').first.split(' ').last}');
    final foldingValue = int.parse(foldingInstruction.split('=').last);
    paper.fold(axis: foldingAxis, value: foldingValue);
  }
  return paper;
}

String printTransparentCode(Input input) =>
    getVisibleDotsAfterCompleteFolding(input).toString();
