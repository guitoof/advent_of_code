typedef Input = List<List<int>>;

class DijkstraNode {
  final int i;
  final int j;
  String get id => '$i-$j';
  final possibleOrigins = <DijkstraNode>[];
  String? previousNodeId;
  int risk;
  late int totalRisk;
  bool visited = false;

  bool operator <=(DijkstraNode other) => totalRisk <= other.totalRisk;
  bool operator <(DijkstraNode other) => totalRisk < other.totalRisk;
  bool operator >=(DijkstraNode other) => totalRisk >= other.totalRisk;
  bool operator >(DijkstraNode other) => totalRisk > other.totalRisk;

  void addPossibleOrigin(DijkstraNode other) {
    if (previousNodeId == null || totalRisk >= risk + other.totalRisk) {
      // Replace
      previousNodeId = other.id;
      totalRisk = risk + other.totalRisk;
    }
  }

  DijkstraNode(
      {required this.i,
      required this.j,
      this.previousNodeId,
      required this.risk}) {
    totalRisk = risk;
  }

  @override
  String toString() => '''
  Node ID: $i-$j
  From: $previousNodeId
  Total Risk: $totalRisk
  ''';
}

class DijkstraResolver {
  final Input map;
  late Map<String, DijkstraNode> table = {};
  late DijkstraNode currentNode;

  DijkstraResolver.fromInput(Input this.map) {
    for (var i = 0; i < map.length; i++) {
      for (var j = 0; j < map[0].length; j++) {
        table.addAll({'$i-$j': DijkstraNode(i: i, j: j, risk: map[i][j])});
      }
    }
    currentNode = table['0-0']!
      ..visited = true
      ..risk = 0
      ..totalRisk = 0;
  }

  bool isLastNode(DijkstraNode node) =>
      node.i == map.length - 1 && node.j == map[0].length - 1;

  void nextStep() {
    if (currentNode.i < map.length - 1) {
      table['${currentNode.i + 1}-${currentNode.j}']!
          .addPossibleOrigin(currentNode);
    }
    if (currentNode.j < map[0].length - 1) {
      table['${currentNode.i}-${currentNode.j + 1}']!
          .addPossibleOrigin(currentNode);
    }
    final nextNodeOptions = table.entries
        .where(
            (node) => !node.value.visited && node.value.previousNodeId != null)
        .toList();
    final nextNode = nextNodeOptions
        .reduce((minNode, node) => minNode.value <= node.value ? minNode : node)
        .value;
    nextNode.visited = true;
    currentNode = nextNode;
  }

  int solve() {
    while (!isLastNode(currentNode)) {
      nextStep();
    }
    return currentNode.totalRisk;
  }
}

int getTotalLowestRisk(Input input) {
  final resolver = DijkstraResolver.fromInput(input);
  return resolver.solve();
}
