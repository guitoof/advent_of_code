import 'package:test/scaffolding.dart';
import '../src/utils/daily_solver.dart';
import '../src/utils/data_source.dart';

class PartTestSuite<S extends DailySolver> {
  final Function(S solver) block;
  final List<DataSourceType> skipTypes;

  PartTestSuite(this.block, {this.skipTypes = const []});
}

final supportedDataSourceTypes = [
  DataSourceType.example,
  DataSourceType.challenge
];

void testSuite<S extends DailySolver>({
  required int day,
  required S Function() solverBuilder,
  required PartTestSuite<S> part1,
  required PartTestSuite<S> part2,
}) {
  final solver = solverBuilder();
  group('Day $day -', () {
    group('Part 1 - ', () {
      for (var type in supportedDataSourceTypes) {
        group('${type.name.toUpperCase()} - ', () {
          setUpAll(() async {
            await solver.loadInputData(ofType: type);
          });

          part1.block(solver);
        }, skip: part1.skipTypes.contains(type));
      }
    });

    group('Part 2 - ', () {
      for (var type in supportedDataSourceTypes) {
        group('${type.name.toUpperCase()} - ', () {
          setUpAll(() async {
            await solver.loadInputData(ofType: type);
          });

          part2.block(solver);
        }, skip: part2.skipTypes.contains(type));
      }
    });
  });
}
