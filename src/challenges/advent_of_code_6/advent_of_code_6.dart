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

    return StartOfPacketMarkerSubroutine.getDataCountToFirstMarker(signal);
  }
}

class Packet {
  final String data;

  Packet(this.data);

  bool get isMarker {
    final chars = data.split('');
    final uniqueChars = chars.toSet();
    return uniqueChars.length == chars.length;
  }
}

mixin StartOfPacketMarkerSubroutine {
  static final int _packetSize = 4;

  static int getDataCountToFirstMarker(String signal) {
    for (var cursor = 0; cursor < signal.length; cursor++) {
      final packet = Packet(signal.substring(cursor, cursor + _packetSize));
      if (packet.isMarker) {
        return cursor + _packetSize;
      }
    }
    return -1;
  }
}
