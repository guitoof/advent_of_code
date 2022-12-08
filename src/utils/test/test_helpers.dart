import 'package:meta/meta.dart';
import 'package:test/scaffolding.dart';
import '../daily_solver.dart';
import '../data_source.dart';

S castSolverType<S extends DailySolver>(DailySolver solver) {
  assert(solver is S, 'Solver is not of type $S');
  return solver as S;
}

@isTestGroup
void dayTestGroup(
  String description, {
  required DailySolver Function() solverBuilder,
  required Map<int, PartTestGroup> partTestGroups,
}) {
  group(description, () {
    partTestGroups.forEach((key, value) {
      partTestGroup('Part $key', value.body,
          solverBuilder: solverBuilder, skipTypes: value.skipTypes);
    });
  });
}

class PartTestGroup {
  final Function(DailySolver, DataSourceType) body;
  final List<DataSourceType> skipTypes;

  PartTestGroup(this.body, {this.skipTypes = const []});
}

final supportedDataSourceTypes = [
  DataSourceType.example,
  DataSourceType.challenge
];

@isTestGroup
void partTestGroup(
  String description,
  Function(DailySolver solver, DataSourceType type) body, {
  required DailySolver Function() solverBuilder,
  required List<DataSourceType> skipTypes,
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
        () => body(solver, type),
        skip: skipTypes.contains(type),
      );
    }
  });
}

@isTestGroup
void testGroupWithExpectedDataByType(
  String description, {
  required Map<DataSourceType, dynamic> expectedDataMap,
  required DataSourceType type,
  required Function({required dynamic expectedData}) body,
}) {
  group(
    description,
    () => body(expectedData: expectedDataMap[type]),
    skip: !expectedDataMap.keys.contains(type),
  );
}
