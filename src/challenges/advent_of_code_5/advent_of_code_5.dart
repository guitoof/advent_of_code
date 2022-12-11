import 'package:equatable/equatable.dart';

import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

class DailySolver5 extends DailySolver<String, String> with GiantCargoCrane {
  DailySolver5({required super.day});

  @override
  String lineParser(String line) => line;

  @override
  Future<void> loadInputData({required DataSourceType ofType}) async {
    /// Because the format is very specific in this case
    /// and the input data contains 2 sections rather than a repetitive pattern
    /// We simply parse the input data roughly line to line at first
    await super.loadInputData(ofType: ofType);

    int sectionSeparatorIndex = inputData.indexWhere((item) => item == '');
    final cratesRawData = inputData.sublist(0, sectionSeparatorIndex);
    cargoBay = CargoBay.loadFromDrawing(cratesRawData);

    rearrangementProcedure = RearrangementProcedure.fromRawData(
      inputData.sublist(sectionSeparatorIndex + 1),
    );
  }

  @override
  Future<String> solve(
      {required int part,
      DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);

    switch (part) {
      case 1:
        return getRearrangedTopCratesLabels();
      default:
        throw Exception('Invalid part: $part');
    }
  }
}

class Crate extends Equatable {
  final String label;

  Crate({required this.label});

  @override
  String toString() => label;

  @override
  List<Object?> get props => [label];
}

class Stack extends Equatable {
  final int id;
  final List<Crate> _crates = [];

  Stack({required this.id});

  @override
  String toString() => _crates.toString();

  @override
  List<Object?> get props => [_crates];
}

class CargoBay extends Equatable {
  final Map<int, Stack> _stacks;

  const CargoBay({required Map<int, Stack> stacks}) : _stacks = stacks;

  factory CargoBay.loadFromDrawing(List<String> drawing) {
    return CratesArrangementDrawingParser.parse(drawing);
  }

  factory CargoBay.ofStacksCount(int stacksCount) {
    return CargoBay(
      stacks: List.generate(
        stacksCount,
        (index) => Stack(id: index),
      ).asMap().map((key, value) => MapEntry(key + 1, value)),
    );
  }

  void loadCrateToStack(Crate crate, int index) {
    final stack = _stacks[index];
    if (stack == null) {
      throw Exception('Invalid stack index: $index');
    }
    stack._crates.add(crate);
  }

  List<Crate> get topLevelCrates {
    return _stacks.values.map((stack) => stack._crates.last).toList();
  }

  void rearrange(RearrangementProcedure procedure) {
    for (var instruction in procedure.instructions) {
      final sourceStack = _stacks[instruction.sourceIndex];
      final destinationStack = _stacks[instruction.destinationIndex];
      if (sourceStack == null || destinationStack == null) {
        throw Exception(
          'Cannot find source stack at: ${instruction.sourceIndex} or destination stack at: ${instruction.destinationIndex}',
        );
      }
      final cratesToMove = sourceStack._crates
          .sublist(sourceStack._crates.length - instruction.quantity);
      destinationStack._crates.addAll(cratesToMove.reversed);
      sourceStack._crates.removeRange(
        sourceStack._crates.length - instruction.quantity,
        sourceStack._crates.length,
      );
    }
  }

  @override
  String toString() => _stacks.toString();

  @override
  List<Object?> get props => [_stacks];
}

class CratesArrangementDrawingParser {
  static final _crateLabelPattern = RegExp(r'\[([A-Z])\]');
  static const int _stackWidth = 4;

  static List<String> extractStackIndexes(String drawingLine) {
    final stackIndexes = drawingLine.split('')
      ..removeWhere((element) => element.trim().isEmpty)
      ..map(int.parse);
    return stackIndexes;
  }

  static Map<int, Crate> extractCratesFromRow(String row) {
    final crates = <int, Crate>{};
    for (int i = 0; i < row.length; i += _stackWidth) {
      final crateLabel = row
          .substring(
            i,
            i + _stackWidth < row.length ? (i + _stackWidth) : null,
          )
          .trim();
      final match = _crateLabelPattern.firstMatch(crateLabel);
      if (match == null) {
        continue;
      }
      final parsedLabel = match.group(1);
      if (parsedLabel == null) {
        continue;
      }
      crates[i ~/ _stackWidth + 1] = Crate(
        label: parsedLabel,
      );
    }
    return crates;
  }

  static CargoBay parse(List<String> drawing) {
    final stackIndexes = extractStackIndexes(drawing.last);
    final cargoBay = CargoBay.ofStacksCount(stackIndexes.length);
    final cratesArrangementDrawing = drawing.sublist(0, drawing.length - 1);
    // Iterate through the rows in reverse order
    // so that we add the bottom crates first
    for (var row in cratesArrangementDrawing.reversed) {
      final rowCrates = extractCratesFromRow(row);
      for (var crateEntry in rowCrates.entries) {
        cargoBay.loadCrateToStack(crateEntry.value, crateEntry.key);
      }
    }
    return cargoBay;
  }
}

class RearrangementProcedure {
  static final RegExp _instructionPattern =
      RegExp(r'move ([0-9]+) from ([0-9]+) to ([0-9]+)');

  List<RearrangementInstruction> instructions = [];

  RearrangementProcedure({required this.instructions});

  RearrangementProcedure.fromRawData(List<String> rawData) {
    instructions = rawData.map((rawInstruction) {
      final match = _instructionPattern.firstMatch(rawInstruction);
      if (match == null || match.groupCount != 3) {
        throw Exception('Invalid instruction: $rawInstruction');
      }
      final quantityInstruction = match.group(1);
      final sourceIndexInstruction = match.group(2);
      final destinationIndexInstruction = match.group(3);
      return RearrangementInstruction(
        quantity: int.parse(quantityInstruction!),
        sourceIndex: int.parse(sourceIndexInstruction!),
        destinationIndex: int.parse(destinationIndexInstruction!),
      );
    }).toList();
  }
  @override
  String toString() => instructions.toString();
}

class RearrangementInstruction {
  final int sourceIndex;
  final int destinationIndex;
  final int quantity;

  RearrangementInstruction({
    required this.quantity,
    required this.sourceIndex,
    required this.destinationIndex,
  });

  @override
  String toString() =>
      'Move ($quantity) from ($sourceIndex) to ($destinationIndex)';
}

mixin GiantCargoCrane {
  late CargoBay cargoBay;
  late RearrangementProcedure rearrangementProcedure;

  String getInitialTopCratesLabels() {
    return cargoBay.topLevelCrates.map((crate) => crate.label).join('');
  }

  String getRearrangedTopCratesLabels() {
    cargoBay.rearrange(rearrangementProcedure);
    return cargoBay.topLevelCrates.map((crate) => crate.label).join('');
  }
}
