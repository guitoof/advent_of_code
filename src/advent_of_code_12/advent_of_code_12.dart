enum CaveSize { small, large }

class Cave {
  final String id;
  List<String> connectedCaveIds = [];

  Cave({required this.id});

  CaveSize get size => id == id.toUpperCase() ? CaveSize.large : CaveSize.small;

  bool get isVisitableMoreThanOnce => size == CaveSize.large;

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

  CaveLayout(List<List<String>> input) {
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
                (id) => Path(caves: [...path.caves, getCaveById(id: id)]),
              )
              .toList());
    }
    return investigateFurther(paths: paths);
  }
}

class Path {
  List<Cave> caves;

  Path({required this.caves});

  List<String> get accessibleCaveIds => caves.last.connectedCaveIds
      .where((caveId) => isCaveWithIdVisitable(caveId: caveId))
      .toList();

  bool isPathComplete() => caves.last.id == 'end';

  bool isCaveWithIdVisitable({required String caveId}) {
    return Cave(id: caveId).isVisitableMoreThanOnce ||
        caves.every((cave) => cave.id != caveId);
  }

  bool isDeadEnd() => accessibleCaveIds.isEmpty && caves.last.id != 'end';

  @override
  String toString() => '${caves.map((cave) => cave.id).join(',')}';
}

bool isMappingComplete(List<Path> paths) =>
    paths.every((path) => path.isPathComplete());

int countPaths(List<List<String>> input) {
  final caveLayout = CaveLayout(input);
  Path initialPath = Path(caves: [caveLayout.getCaveById(id: 'start')]);
  List<Path> paths = [initialPath];
  while (!isMappingComplete(paths)) {
    paths = caveLayout.investigateFurther(paths: paths);
  }
  return paths.length;
}
