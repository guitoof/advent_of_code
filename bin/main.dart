import '../src/advent_of_code_1/advent_of_code_1.dart';
import '../src/advent_of_code_1/data_source.dart';
import '../src/advent_of_code_2/advent_of_code_2.dart';
import '../src/advent_of_code_2/data_source.dart';
import '../src/advent_of_code_3/advent_of_code_3.dart';
import '../src/advent_of_code_3/data_source.dart';
import '../src/advent_of_code_4/advent_of_code_4.dart';
import '../src/advent_of_code_4/data_source.dart';
import '../src/advent_of_code_5/advent_of_code_5.dart';
import '../src/advent_of_code_5/data_source.dart';
import '../src/advent_of_code_6/advent_of_code_6.dart';
import '../src/advent_of_code_6/data_source.dart';
import '../src/advent_of_code_7/advent_of_code_7.dart';
import '../src/advent_of_code_7/data_source.dart';
import '../src/advent_of_code_8/advent_of_code_8.dart';
import '../src/advent_of_code_8/data_source.dart';
import '../src/advent_of_code_9/advent_of_code_9.dart';
import '../src/advent_of_code_9/data_source.dart';
import '../src/advent_of_code_10/advent_of_code_10.dart';
import '../src/advent_of_code_10/data_source.dart';
import '../src/advent_of_code_11/advent_of_code_11.dart';
import '../src/advent_of_code_11/data_source.dart';
import '../src/advent_of_code_12/advent_of_code_12.dart';
import '../src/advent_of_code_12/data_source.dart';
import '../src/advent_of_code_13/advent_of_code_13.dart';
import '../src/advent_of_code_13/data_source.dart';

const today = 13;

void displayAdventOfCodeResponse(
    {required int day,
    String name = '',
    dynamic part1Response,
    dynamic part2Response}) async {
  print("📆 Day $day - $name");
  if (part1Response != null) print('⭐️ Part 1: $part1Response');
  if (part2Response != null) print('⭐️ Part 2: $part2Response');
  print("--------------------------------------------------------");
}

Future<void> runAdventOfCodeProgram({int? day}) async {
  switch (day) {
    case 1:
      final input = await getInput1Data();
      displayAdventOfCodeResponse(
        day: 1,
        part1Response: countIncreasingMeasurements(input),
        part2Response:
            countIncreasingMeasurementsByWindow(input, windowSize: 3),
      );
      break;
    case 2:
      final input = await getInput2Data();
      displayAdventOfCodeResponse(
        day: 2,
        part1Response:
            getCoordinatesProductForFinalPosition(moveCommands: input),
        part2Response: getCoordinatesProductForFinalPosition(
          moveCommands: input,
          interpretationMethod: CommandInterpretationMethod.aim,
        ),
      );
      break;
    case 3:
      final input = await getInput3Data();
      displayAdventOfCodeResponse(
        day: 3,
        part1Response: getPowerConsumption(report: input),
        part2Response: getLifeSupportRating(report: input),
      );
      break;
    case 4:
      final input = await getInput4Data();
      displayAdventOfCodeResponse(
        day: 4,
        part1Response: getBingoScore(
            bingoBoards: input.bingoBoards.map(parseInputBoard).toList(),
            drawnNumbers: input.drawnNumbers),
        part2Response: getBingoScore(
            bingoBoards: input.bingoBoards.map(parseInputBoard).toList(),
            drawnNumbers: input.drawnNumbers,
            which: BingoBoardWinningPlace.last),
      );
      break;
    case 5:
      final input = await getInput5Data();
      displayAdventOfCodeResponse(
        day: 5,
        part1Response:
            getDangerousAreasMapping(input, size: 1000, excludeDiagonals: true),
        part2Response: getDangerousAreasMapping(input, size: 1000),
      );
      break;
    case 6:
      final input = await getInput6Data();
      displayAdventOfCodeResponse(
        day: 6,
        part1Response: simulateLanternFishProduction(input, days: 80),
        part2Response: simulateOptimizedLanternFishProduction(input, days: 256),
      );
      break;
    case 7:
      final input = await getInput7Data();
      displayAdventOfCodeResponse(
        day: 7,
        part1Response: getFuelConsumption(input),
        part2Response: getDynamicFuelConsumption(input),
      );
      break;
    case 8:
      final input = await getInput8Data();
      displayAdventOfCodeResponse(
        day: 8,
        part1Response: countSimpleDigits(input),
        part2Response: sumAllDecodedOutputValues(input),
      );
      break;
    case 9:
      final input = await getInput9Data();
      displayAdventOfCodeResponse(
        day: 9,
        part1Response: sumMinHeights(input),
        part2Response: getLargestBassinArea(input),
      );
      break;
    case 10:
      final input = await getInput10Data();
      displayAdventOfCodeResponse(
        day: 10,
        part1Response: getSyntaxCheckerScore(input),
        part2Response: getAutocompleteScore(input),
      );
      break;
    case 11:
      final input = await getInput11Data();
      displayAdventOfCodeResponse(
        day: 11,
        part1Response: countOctopusFlashes(input, steps: 100),
        part2Response: firstSyncFlash(input),
      );
      break;
    case 12:
      final input = await getInput12Data();
      displayAdventOfCodeResponse(
        day: 12,
        name: 'Passage Pathing',
        part1Response: countPaths(input),
        part2Response:
            countPaths(input, method: CaveExplorationMethod.oneSmallCaveTwice),
      );
      break;
    case 13:
      final input = await getInput13Data();
      displayAdventOfCodeResponse(
        day: 13,
        name: 'Transparent Origami',
        part1Response: countVisibleDotsAfterFoldingOnce(input),
      );
      break;
    default:
      for (var _day = 1; _day <= today; _day++) {
        await runAdventOfCodeProgram(day: _day);
      }
      print('#####################################');
      print('$today ⭐️ collected 🙌');
      print('⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️');
      print('⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️');
      print('⭐️⭐️⭐️⭐️');
      break;
  }
}

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    return runAdventOfCodeProgram();
  }

  final option = arguments[0].split('=')[0];
  if (option == '--day') {
    int day = int.parse(arguments[0].split('=')[1]);
    return runAdventOfCodeProgram(day: day);
  }
  throw Exception('Unknown option $option');
}
