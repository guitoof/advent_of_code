import 'package:test/scaffolding.dart';
import '../src/utils/daily_solver.dart';
import '../src/utils/data_source.dart';

void testSuite({
  required int day,
  required DailySolver Function() solverBuilder,
  required Function part1TestBlock,
  required Function part2TestBlock,
}) {
  late DailySolver solver;
  group('Day $day -', () {
    setUpAll(() {
      solver = solverBuilder();
    });

    group('Part 1 - ', () {
      for (var type in [DataSourceType.example, DataSourceType.challenge]) {
        group('${type.name.toUpperCase()} - ', () {
          setUpAll(() async {
            await solver.loadInputData(ofType: type);
          });

          part1TestBlock();
        }, skip: type != DataSourceType.example);
      }
    });

    group('Part 2 - ', () {
      for (var type in [DataSourceType.example, DataSourceType.challenge]) {
        group('${type.name.toUpperCase()} - ', () {
          setUpAll(() async {
            await solver.loadInputData(ofType: type);
          });

          part2TestBlock();
        }, skip: type != DataSourceType.example);
      }
    });
  });
}
