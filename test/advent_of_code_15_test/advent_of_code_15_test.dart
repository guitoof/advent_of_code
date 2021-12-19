import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../src/advent_of_code_15/advent_of_code_15.dart';
import '../../src/advent_of_code_15/data_source.dart';
import '../../src/utils/data_source.dart' hide getInputData;

Future<Input> getInputData() async {
  return getTestInputData<List<int>>(id: 15, parser: input15Parser);
}

void main() {
  group('getTotalLowestRisk', () {
    test('should return the total risk following the lowest risk path',
        () async {
      final input = await getInputData();
      expect(getTotalLowestRisk(input), 40);
    });
  });
}
