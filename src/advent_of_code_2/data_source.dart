import 'advent_of_code_2.dart';
import '../utils/data_source.dart';

Future<List<MoveCommand>> getInput2Data() async {
  return getInputData<MoveCommand>(
      id: 2,
      parser: (line) {
        var rawCommand = line.split(' ');
        return MoveCommand(
          type: MoveCommandType.values.firstWhere(
              (type) => type.toString() == 'MoveCommandType.${rawCommand[0]}'),
          value: int.parse(rawCommand[1]),
        );
      });
}
