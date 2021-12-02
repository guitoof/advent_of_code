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

int getCoordinatesProductForFinalPosition(List<MoveCommand> moveCommands) {
  Point<int> position = Point<int>(0, 0);
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
  return position.x * position.y;
}
