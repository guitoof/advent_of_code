typedef Input = List<List<int>>;

abstract class PathFindingResolver {
  PathFindingResolver();

  PathFindingResolver.fromInput(Input input, {int expansionFactor = 1});

  int solve();
}
