import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../src/advent_of_code_2/advent_of_code_2.dart';

void main() {
  test(
      'should return the product x*y where (x,y) represents the coordinates of the final position',
      () {
    const input = [
      MoveCommand(type: MoveCommandType.forward, value: 5),
      MoveCommand(type: MoveCommandType.down, value: 5),
      MoveCommand(type: MoveCommandType.forward, value: 8),
      MoveCommand(type: MoveCommandType.up, value: 3),
      MoveCommand(type: MoveCommandType.down, value: 8),
      MoveCommand(type: MoveCommandType.forward, value: 2),
    ];
    expect(getCoordinatesProductForFinalPosition(moveCommands: input), 150);
  });

  test(
      'should return the product x*y where (x,y) represents the coordinates of the final position using the "aim" based interpretation of commands',
      () {
    const input = [
      MoveCommand(type: MoveCommandType.forward, value: 5),
      MoveCommand(type: MoveCommandType.down, value: 5),
      MoveCommand(type: MoveCommandType.forward, value: 8),
      MoveCommand(type: MoveCommandType.up, value: 3),
      MoveCommand(type: MoveCommandType.down, value: 8),
      MoveCommand(type: MoveCommandType.forward, value: 2),
    ];
    expect(
        getCoordinatesProductForFinalPosition(
            moveCommands: input,
            interpretationMethod: CommandInterpretationMethod.aim),
        900);
  });
}
