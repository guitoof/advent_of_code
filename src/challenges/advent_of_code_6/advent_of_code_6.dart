import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

class DailySolver6 extends DailySolver<String, int>
    with StartOfPacketMarkerSubroutine {
  DailySolver6({required super.day, required super.part});

  @override
  String lineParser(String line) => line;

  @override
  Future<void> loadInputData({required DataSourceType ofType}) async {
    await super.loadInputData(ofType: ofType);
  }

  @override
  Future<OutputType> solve(
      {DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);

    final signal = inputData.first;

    switch (part) {
      case 1:
        return StartOfPacketMarkerSubroutine.getFirstPacketSize(signal);
      case 2:
        return StartOfPacketMarkerSubroutine.getFirstMessageSize(signal);
      default:
        throw Exception('Unsupported part: $part');
    }
  }
}

class MarkerCandidate {
  final String data;

  MarkerCandidate(this.data);

  bool get isMarker {
    final chars = data.split('');
    final uniqueChars = chars.toSet();
    return uniqueChars.length == chars.length;
  }
}

abstract class MarkerDetector {
  int get scopeSize;

  int getFirstMarkerCursor(String signal) {
    for (var cursor = 0; cursor < signal.length; cursor++) {
      final candidate =
          MarkerCandidate(signal.substring(cursor, cursor + scopeSize));
      if (candidate.isMarker) {
        return cursor;
      }
    }
    return -1;
  }

  int getFirstDataPieceSize(String signal) =>
      getFirstMarkerCursor(signal) + scopeSize;
}

class PacketMarkerDetector extends MarkerDetector {
  @override
  int get scopeSize => 4;
}

class MessageMarkerDetector extends MarkerDetector {
  @override
  int get scopeSize => 14;
}

mixin StartOfPacketMarkerSubroutine {
  static int getFirstPacketSize(String signal) {
    return PacketMarkerDetector().getFirstDataPieceSize(signal);
  }

  static int getFirstMessageSize(String signal) {
    return MessageMarkerDetector().getFirstDataPieceSize(signal);
  }
}
