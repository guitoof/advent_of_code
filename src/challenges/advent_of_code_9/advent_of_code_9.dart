import 'dart:math';

import 'package:equatable/equatable.dart';

import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

class DailySolver9 extends DailySolver<Command, int> with RopeDriver {
  DailySolver9({required super.day, required super.part});

  @override
  Command lineParser(String line) {
    // Here was the problem: line.split('') instead of line.split(' ')
    final commandData = line.split(' ');
    return Command(
      direction: Direction.fromStringCode(commandData.first),
      distance: int.parse(commandData.last),
    );
  }

  @override
  Future<void> loadInputData({required DataSourceType ofType}) async {
    await super.loadInputData(ofType: ofType);
    commands = inputData;
  }

  @override
  Future<int> solve({DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);

    switch (part) {
      case 1:
        moveShortRope();
        return getUniqueTailVisitedPositionsCountForShortRope();
      case 2:
        moveLongRope();
        return getUniqueTailVisitedPositionsCountForLongRope();
      default:
        throw ArgumentError('Unsupported part: $part');
    }
  }
}

enum Direction {
  up,
  right,
  down,
  left;

  factory Direction.fromStringCode(String code) {
    switch (code) {
      case 'R':
        return Direction.right;
      case 'U':
        return Direction.up;
      case 'L':
        return Direction.left;
      case 'D':
        return Direction.down;
      default:
        throw ArgumentError(
          'Unsupported string code: $code, to parse $Direction',
        );
    }
  }
}

class Command {
  final Direction direction;
  final int distance;

  Command({required this.direction, required this.distance});

  @override
  String toString() => '$direction, $distance';
}

// ignore: must_be_immutable
class LongRope extends Equatable {
  List<ShortRope> nodes = <ShortRope>[];

  ShortRope get headRope => nodes.first;
  set headRope(ShortRope newHeadRope) {
    nodes.first = newHeadRope;
  }

  ShortRope get tailRope => nodes.last;
  set tailRope(ShortRope newTailRope) {
    nodes.last = newTailRope;
  }

  Point get head => headRope.head;
  set head(Point newHead) {
    headRope.head = newHead;
  }

  Point get tail => tailRope.tail;
  set tail(Point newTail) {
    headRope.head = newTail;
  }

  LongRope.fromPoints(List<Point> points) {
    for (var i = 0; i < points.length - 1; i++) {
      nodes.add(ShortRope(head: points[i], tail: points[i + 1]));
    }
  }

  void propagateToNodes() {
    for (var i = 1; i < nodes.length; i++) {
      nodes[i].head = nodes[i - 1].tail;
      nodes[i].catchupTail();
    }
  }

  void moveHeadByOne({required Direction direction}) {
    headRope.moveHeadByOne(direction: direction);
    propagateToNodes();
  }

  int get countTailVisitedPositions => tailRope.countTailVisitedPositions;

  @override
  List<Object?> get props => [nodes];

  @override
  String toString() => '''
${[
        for (var row = -50; row <= 50; row++)
          [
            for (var col = -50; col <= 50; col++)
              tailRope.tailVisitedPositions.contains(Point(col, row))
                  ? '#'
                  : '.'
          ].join('')
      ].join('\n')}
    ''';
}

// ignore: must_be_immutable
class ShortRope extends Equatable {
  Point head = Point(0, 0);
  Point tail = Point(0, 0);
  late List<Point> tailVisitedPositions = [];

  ShortRope({required this.head, required this.tail}) {
    tailVisitedPositions.add(tail);
  }

  int get countTailVisitedPositions => tailVisitedPositions.length;

  @override
  String toString() => 'Head: $head, Tail: $tail';

  void moveHeadByOne({required Direction direction}) {
    switch (direction) {
      case Direction.up:
        head = Point(head.x, head.y + 1);
        break;
      case Direction.right:
        head = Point(head.x + 1, head.y);
        break;
      case Direction.down:
        head = Point(head.x, head.y - 1);
        break;
      case Direction.left:
        head = Point(head.x - 1, head.y);
        break;
    }
    catchupTail();
  }

  void catchupTail() {
    if (tail == head) return;

    if (head - tail == Point(1, 0) ||
        head - tail == Point(0, 1) ||
        head - tail == Point(-1, 0) ||
        head - tail == Point(0, -1) ||
        head - tail == Point(1, 1) ||
        head - tail == Point(1, -1) ||
        head - tail == Point(-1, 1) ||
        head - tail == Point(-1, -1)) {
      return;
    }

    if (head - tail == Point(2, 0)) {
      tail = Point(tail.x + 1, tail.y);
    } else if (head - tail == Point(0, 2)) {
      tail = Point(tail.x, tail.y + 1);
    } else if (head - tail == Point(-2, 0)) {
      tail = Point(tail.x - 1, tail.y);
    } else if (head - tail == Point(0, -2)) {
      tail = Point(tail.x, tail.y - 1);
    } else if (head - tail == Point(2, 1) || head - tail == Point(1, 2)) {
      tail = Point(tail.x + 1, tail.y + 1);
    } else if (head - tail == Point(2, -1) || head - tail == Point(1, -2)) {
      tail = Point(tail.x + 1, tail.y - 1);
    } else if (head - tail == Point(-2, 1) || head - tail == Point(-1, 2)) {
      tail = Point(tail.x - 1, tail.y + 1);
    } else if (head - tail == Point(-2, -1) || head - tail == Point(-1, -2)) {
      tail = Point(tail.x - 1, tail.y - 1);
    } else if (head - tail == Point(2, 2)) {
      tail = Point(tail.x + 1, tail.y + 1);
    } else if (head - tail == Point(-2, -2)) {
      tail = Point(tail.x - 1, tail.y - 1);
    } else if (head - tail == Point(2, -2)) {
      tail = Point(tail.x + 1, tail.y - 1);
    } else if (head - tail == Point(-2, 2)) {
      tail = Point(tail.x - 1, tail.y + 1);
    } else {
      throw Exception('Tail is too far away from head: T: $tail, H: $head');
    }
    addVisitedPosition(tail);
  }

  void addVisitedPosition(Point point) {
    if (tailVisitedPositions.contains(point)) {
      return;
    }
    tailVisitedPositions.add(point);
  }

  @override
  List<Object?> get props => [head, tail];
}

mixin RopeDriver {
  late List<Command> commands;
  final rope = ShortRope(head: Point(0, 0), tail: Point(0, 0));
  final longRope = LongRope.fromPoints(List.generate(
    10,
    ((_) => Point(0, 0)),
  ));

  void moveShortRope() {
    for (var command in commands) {
      for (var i = 0; i < command.distance; i++) {
        rope.moveHeadByOne(direction: command.direction);
      }
    }
  }

  void moveLongRope() {
    for (var command in commands) {
      for (var i = 0; i < command.distance; i++) {
        longRope.moveHeadByOne(direction: command.direction);
      }
    }
  }

  getUniqueTailVisitedPositionsCountForShortRope() {
    return rope.countTailVisitedPositions;
  }

  getUniqueTailVisitedPositionsCountForLongRope() {
    return longRope.countTailVisitedPositions;
  }
}
