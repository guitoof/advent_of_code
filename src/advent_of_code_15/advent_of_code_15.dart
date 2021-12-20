import 'a_star.dart';
import 'dijkstra.dart';
import 'path_finding_resolver.dart';

enum PathFindingAlgorithm { dijkstra, aStar }

int getTotalLowestRisk(
  Input input, {
  int expansionFactor = 1,
  PathFindingAlgorithm algorithm = PathFindingAlgorithm.aStar,
}) {
  PathFindingResolver resolver;
  switch (algorithm) {
    case PathFindingAlgorithm.dijkstra:
      resolver =
          DijkstraResolver.fromInput(input, expansionFactor: expansionFactor);
      break;
    case PathFindingAlgorithm.aStar:
      resolver =
          AStarResolver.fromInput(input, expansionFactor: expansionFactor);
      break;
  }
  final start = DateTime.now().millisecondsSinceEpoch;
  final result = resolver.solve();
  final end = DateTime.now().millisecondsSinceEpoch;
  print('Algorithm Duration: ${(end - start) / 1000}');
  return result;
}
