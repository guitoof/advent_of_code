import 'package:test/scaffolding.dart';
import '../src/utils/daily_solver.dart';
import '../src/utils/data_source.dart';

S castSolverType<S extends DailySolver>(DailySolver solver) {
  assert(solver is S, 'Solver is not of type $S');
  return solver as S;
}

void dayTestGroup({
  required int day,
  required DailySolver Function() solverBuilder,
  required Map<int, PartTestGroup> partTestGroups,
}) {
  group('Day $day', () {
    partTestGroups.forEach((key, value) {
      partTestGroup('Part $key', value.body,
          solverBuilder: solverBuilder, skipTypes: value.skipTypes);
    });
  });
}

class PartTestGroup {
  final Function(DailySolver) body;
  final List<DataSourceType> skipTypes;

  PartTestGroup(this.body, {this.skipTypes = const []});
}

final supportedDataSourceTypes = [
  DataSourceType.example,
  DataSourceType.challenge
];

void partTestGroup(
  String description,
  Function(DailySolver solver) body, {
  required DailySolver Function() solverBuilder,
  List<DataSourceType> skipTypes = const [],
}) {
  group(description, () {
    for (var type in supportedDataSourceTypes) {
      DailySolver solver = solverBuilder();
      setUp(() {
        return Future(() async {
          await solver.loadInputData(ofType: type);
        });
      });

      group(
        '${type.name.toUpperCase()} - ',
        () => body(solver),
        skip: skipTypes.contains(type),
      );
    }
  });
}
