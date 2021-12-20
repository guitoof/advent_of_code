/// Thanks to Topaz for their python solution that helped me understand the A* algorithm
/// https://topaz.github.io/paste/#XQAAAQBEBwAAAAAAAAA5Gwiv/goZ5YR8YlS2UajS0GHqMIZ6o+som6WnfK/58UfKulLoSCfOXYB5+4MjB9UOs1cgVStxwZ5tMSn6JfWbkW8rlOzeJ583rR+HZBbHw/cGEs4aUpyjF4LEgyD8WPV64k5JCg8sQXkZbcSwfuU9AwQnSdMtHAx0U9HLJaKVgPfB1+Fwgq+YaiBMnOuQWUymZrh1aAEEFV/7mWmGrvA6nDWDeb7H2WNgRdiIkqsTFxRFKveX8DCE3VJqkY3IGxHZbW8AA0QssJ8c7dHX0ApHsbX+J3aLPl3Did9r999mWor3sZraqkzuUhdgEXG0tpdgN+QajU9SVQtR/6fL3u3K+KdlGMF3vyeQ4mt9nJgAIruREDpAEybm7ILBJRSnepPHn1Ni5hdZg9z4/Q+mBGDSicxzW5YAKxQafEEbsBw03zwy+f8ClmHS13d4AoBIeyvhD55J1mFGPb5zutWB0dJygtHoD2Cj9YCHeF/9fVqh+0PK0rEgtOW+Y3i3FZJHLoBCerVKfSc/F4+BzISBPdaF+hXeGGB3NF1Ix3gZfV2+2iW6LraRC8SYz9EtJUp+RDJog1eq07AHtdSF+YFWTlKm31mZWypkNxNXIAzOn31DUBTnUu3pxk0rCuh0Ioo+OCth5xSmePjIQ9QIgFT0wFoFhzmL0Nj2hzOqmv69Kd8k8vN7NjuNvQYFeWVldqAEFZWot/YXo8nNqzWNOh8Shw39A6AWn58PJP6BK0Qkeh2d+diuRxLmFZhUq4S0jxvmv3xNAYNGhslh0XBHxBA4CXuZC1zKDQM3Z5z41m+WIAiumhAJrLE14mMz9CjTzkEr7llyEoVpNFAuyo5HI3SItr9e3/gg2PROCZsNY5c8aCGUL2o9podPEGUiTaaVWUyWFhH13G1sTjQPL0HvNXcZzNXfyTeW3Yiph8+WTh4eUG7TQJYnGOt9Y+3qH1L7PzmtmjlAhcU8TZ0D3yFfQM+W1oQQNPldhZA0IPhUV5eMU2wYj8detWikcb0s1EofIyX89rCjbDn4FhYsZG15A0HjXzreNh3DpOr68l+ehWpLXGLLENYKAGS/vAuxQhrDJZLppsHvvxjP4f/jh4zm71QPdMA1wEV6pT7ofrY10IMS3aJYInmO9DtaIN9Dv8ma/pLPiFpnF9msHFJ5SKGKWXONcPmGLxChdGSKADPLQpC+//cweu8=

import 'dart:math' hide Point;
import './path_finding_resolver.dart';

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  operator ==(Object other) => other is Point && x == other.x && y == other.y;

  @override
  int get hashCode => 1000000 * x + y;

  @override
  String toString() => '($x, $y)';
}

class AStarNode {
  final int risk;
  final int estimatedRemainingRisk;

  AStarNode({required this.risk, required this.estimatedRemainingRisk});

  @override
  String toString() => '(risk: $risk, remainingRisk: $estimatedRemainingRisk)';
}

class AStarResolver extends PathFindingResolver {
  final Input map;
  final int expansionFactor;
  late int width;
  late int height;
  final Map<Point, AStarNode> open = {};
  final Map<Point, AStarNode> closed = {};

  AStarResolver.fromInput(this.map, {this.expansionFactor = 1}) {
    width = map[0].length;
    height = map.length;
  }

  int getRiskLevelForPosition(int x, int y) {
    final initialTileRisk = map[y % height][x % width];
    final u = x ~/ width;
    final v = y ~/ height;
    return (initialTileRisk + u + v) ~/ 10 + (initialTileRisk + u + v) % 10;
  }

  Iterable<Point> getNeighboursForPosition(x, y) sync* {
    if (x > 0) yield Point(x - 1, y);
    if (x < expansionFactor * width - 1) yield Point(x + 1, y);
    if (y > 0) yield Point(x, y - 1);
    if (y < expansionFactor * height - 1) yield Point(x, y + 1);
  }

  int estimateRemainingDist(int x, int y) {
    return (expansionFactor * width - 1 - x) +
        (expansionFactor * height - 1 - y);
  }

  bool hasReachedEnd() => closed.containsKey(
      Point(expansionFactor * width - 1, expansionFactor * height - 1));

  int solve() {
    open.addAll({
      Point(0, 0): AStarNode(
          risk: 0, estimatedRemainingRisk: estimateRemainingDist(0, 0))
    });

    while (!hasReachedEnd()) {
      // Move the most promising entry from open to closed
      final nextNode = open.entries.reduce((minPoint, point) =>
          minPoint.value.estimatedRemainingRisk + minPoint.value.risk <=
                  point.value.risk + point.value.estimatedRemainingRisk
              ? minPoint
              : point);
      // print('NEXT NODE: ${nextNode.key}');
      closed.addAll({nextNode.key: nextNode.value});
      open.removeWhere((key, _) => nextNode.key == key);

      // Add all neighbours to open if they are not already in closed
      for (var neighbour
          in getNeighboursForPosition(nextNode.key.x, nextNode.key.y)) {
        // print(neighbour);
        if (!closed.containsKey(neighbour)) {
          final riskFromOrigin = min<int>(
            open[neighbour]?.risk ?? 99999999999,
            nextNode.value.risk +
                getRiskLevelForPosition(
                  neighbour.x,
                  neighbour.y,
                ),
          );
          open.addAll({
            neighbour: AStarNode(
                risk: riskFromOrigin,
                estimatedRemainingRisk: estimateRemainingDist(
                  neighbour.x,
                  neighbour.y,
                ))
          });
        }
      }
      // print(closed);
    }
    return closed[
            Point(expansionFactor * height - 1, expansionFactor * width - 1)]!
        .risk;
  }
}
