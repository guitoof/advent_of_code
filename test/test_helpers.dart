import 'package:test/scaffolding.dart';
import '../src/utils/daily_solver.dart';
import '../src/utils/data_source.dart';

void testSuite<S extends DailySolver>({
  required int day,
  required S Function() solverBuilder,
  required Function(S solver) part1TestBlock,
  required Function(S solver) part2TestBlock,
}) {
  final solver = solverBuilder();
  group('Day $day -', () {
    group('Part 1 - ', () {
      for (var type in [DataSourceType.example, DataSourceType.challenge]) {
        group('${type.name.toUpperCase()} - ', () {
          setUpAll(() async {
            await solver.loadInputData(ofType: type);
          });

          part1TestBlock(solver);
        }, skip: type != DataSourceType.example);
      }
    });

    group('Part 2 - ', () {
      for (var type in [DataSourceType.example, DataSourceType.challenge]) {
        group('${type.name.toUpperCase()} - ', () {
          setUpAll(() async {
            await solver.loadInputData(ofType: type);
          });

          part2TestBlock(solver);
        }, skip: type != DataSourceType.example);
      }
    });
  });
}
