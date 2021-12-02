import 'dart:math';

enum MoveCommandType {
  /// forward - 1
  forward,

  /// down - 2
  down,

  /// up - 3
  up
}

class MoveCommand {
  final MoveCommandType type;
  final int value;

  const MoveCommand({required this.type, required this.value});
}

Point<int> _move({
  Point<int> initialPosition = const Point<int>(0, 0),
  List<MoveCommand> moveCommands = const [],
}) {
  Point<int> position = initialPosition;
  for (var command in moveCommands) {
    switch (command.type) {
      case MoveCommandType.forward:
        position += Point<int>(command.value, 0);
        break;
      case MoveCommandType.down:
        position += Point<int>(0, command.value);
        break;
      case MoveCommandType.up:
        position -= Point<int>(0, command.value);
        break;
    }
  }
  return position;
}

enum CommandInterpretationMethod {
  classic,
  aim,
}

int getCoordinatesProductForFinalPosition(
    {required List<MoveCommand> moveCommands,
    CommandInterpretationMethod interpretationMethod =
        CommandInterpretationMethod.classic}) {
  Point<int> position = _move(moveCommands: moveCommands);
  return position.x * position.y;
}
