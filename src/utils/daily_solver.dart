import 'data_source.dart';

class MissingImplementation extends Error {}

class UnsupportedCase extends Error {}

typedef InputType<T> = List<T>;
typedef OutputType = int;

class DailySolver<T, O> {
  int day;
  int part;
  late List<T> inputData;

  DailySolver({required this.day, required this.part});

  /// IMPLEMENT
  T lineParser(String line) => throw MissingImplementation();

  /// IMPLEMENT
  /// Must call super.loadInputData
  Future<void> loadInputData({required DataSourceType ofType}) async {
    inputData = await getInputData<T>(
      day: day,
      type: ofType,
      lineParser: lineParser,
    );
  }

  /// IMPLEMENT
  /// Must call super.loadInputData
  Future<O> solve() => throw MissingImplementation();
}
