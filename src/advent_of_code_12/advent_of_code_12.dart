enum CaveSize { small, large }

enum CaveExplorationMethod { smallCavesOnlyOnce, oneSmallCaveTwice }

class Cave {
  final String id;
  List<String> connectedCaveIds = [];

  Cave({required this.id});

  CaveSize get size => id == id.toUpperCase() ? CaveSize.large : CaveSize.small;

  bool get isVisitableOnlyOnce => (id == 'start' || id == 'end');
  bool get isAlwaysVisitable => size == CaveSize.large;

  @override
  String toString() {
    return '''
      Cave($id)
      Connected to: $connectedCaveIds
    ''';
  }
}

class CaveLayout {
  List<Cave> caves = [];
  final CaveExplorationMethod method;

  CaveLayout(List<List<String>> input, {required this.method}) {
    for (var connection in input) {
      final fromCave = connection[0];
      final toCave = connection[1];
      if (caves.where((cave) => cave.id == fromCave).isNotEmpty) {
        final cave = caves.firstWhere((cave) => cave.id == fromCave);
        cave.connectedCaveIds.add(toCave);
      } else {
        caves.add(Cave(id: fromCave)..connectedCaveIds.add(toCave));
      }

      if (caves.where((cave) => cave.id == toCave).isNotEmpty) {
        final cave = caves.firstWhere((cave) => cave.id == toCave);
        cave.connectedCaveIds.add(fromCave);
      } else {
        caves.add(Cave(id: toCave)..connectedCaveIds.add(fromCave));
      }
    }
  }

  Cave getCaveById({required String id}) =>
      caves.firstWhere((cave) => cave.id == id);

  List<Path> investigateFurther({required List<Path> paths}) {
    if (isMappingComplete(paths)) return paths;
    for (var index = 0; index < paths.length; index++) {
      final path = paths[index];
      if (path.isPathComplete()) continue;
      if (path.isDeadEnd()) {
        paths.remove(path);
        index--;
        continue;
      }
      paths.replaceRange(
          index,
          index + 1,
          path.accessibleCaveIds
              .map(
                (id) => Path(
                    caves: [...path.caves, getCaveById(id: id)],
                    method: method),
              )
              .toList());
    }
    return investigateFurther(paths: paths);
  }
}

class Path {
  List<Cave> caves;
  final CaveExplorationMethod method;

  Path({required this.caves, required this.method});

  List<String> get accessibleCaveIds => caves.last.connectedCaveIds
      .where((caveId) => canVisitCaveWithId(caveId: caveId))
      .toList();

  Cave? findDuplicateSmallCave() {
    Cave? duplicate;
    final smallCaves =
        caves.where((cave) => cave.size == CaveSize.small).toList();
    if (smallCaves.isEmpty) return null;
    for (var cave in smallCaves) {
      final potentialDuplicates =
          smallCaves.where((other) => cave.id == other.id).toList();
      if (potentialDuplicates.length >= 2) return potentialDuplicates[1];
    }
    return duplicate;
  }

  bool alreadyHaveVisitedSmallCaveTwice() => findDuplicateSmallCave() != null;

  bool isPathComplete() => caves.last.id == 'end';

  bool canVisitCaveWithId({required String caveId}) {
    if (Cave(id: caveId).isVisitableOnlyOnce &&
        caves.any((cave) => cave.id == caveId)) return false;

    if (Cave(id: caveId).size == CaveSize.small) {
      if (method == CaveExplorationMethod.smallCavesOnlyOnce ||
          alreadyHaveVisitedSmallCaveTwice()) {
        return caves.every((cave) => cave.id != caveId);
      }
      return true;
    }

    return Cave(id: caveId).isAlwaysVisitable;
  }

  bool isDeadEnd() => accessibleCaveIds.isEmpty && caves.last.id != 'end';

  @override
  String toString() => caves.map((cave) => cave.id).join(',');
}

bool isMappingComplete(List<Path> paths) =>
    paths.every((path) => path.isPathComplete());

int countPaths(List<List<String>> input,
    {CaveExplorationMethod method = CaveExplorationMethod.smallCavesOnlyOnce}) {
  final caveLayout = CaveLayout(input, method: method);
  Path initialPath =
      Path(caves: [caveLayout.getCaveById(id: 'start')], method: method);
  List<Path> paths = [initialPath];
  while (!isMappingComplete(paths)) {
    paths = caveLayout.investigateFurther(paths: paths);
  }
  return paths.length;
}
