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

class AimingPoint<T extends num> {
  final T x;
  final T y;
  final T aim;
  const AimingPoint(this.x, this.y, {required this.aim});

  AimingPoint<T> operator +(AimingPoint<T> other) {
    return AimingPoint<T>((x + other.x) as T, (y + other.y) as T,
        aim: (aim + other.aim) as T);
  }

  AimingPoint<T> operator -(AimingPoint<T> other) {
    return AimingPoint<T>((x - other.x) as T, (y - other.y) as T,
        aim: (aim - other.aim) as T);
  }
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

AimingPoint<int> _moveWithAim({
  AimingPoint<int> initialPosition = const AimingPoint<int>(0, 0, aim: 0),
  List<MoveCommand> moveCommands = const [],
}) {
  AimingPoint<int> position = initialPosition;
  for (var command in moveCommands) {
    switch (command.type) {
      case MoveCommandType.forward:
        position += AimingPoint<int>(
            command.value, position.aim * command.value,
            aim: 0);
        break;
      case MoveCommandType.down:
        position += AimingPoint<int>(0, 0, aim: command.value);
        break;
      case MoveCommandType.up:
        position -= AimingPoint<int>(0, 0, aim: command.value);
        break;
    }
  }
  return position;
}

enum CommandInterpretationMethod {
  classic,
  aim,
}

int getCoordinatesProductForFinalPosition({
  required List<MoveCommand> moveCommands,
  CommandInterpretationMethod interpretationMethod =
      CommandInterpretationMethod.classic,
}) {
  switch (interpretationMethod) {
    case CommandInterpretationMethod.classic:
      Point<int> position = _move(moveCommands: moveCommands);
      return position.x * position.y;
    case CommandInterpretationMethod.aim:
      AimingPoint<int> position = _moveWithAim(moveCommands: moveCommands);
      return position.x * position.y;
  }
}
