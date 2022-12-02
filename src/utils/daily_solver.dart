import 'data_source.dart';

class MissingImplementation extends Error {}

class UnsupportedCase extends Error {}

typedef InputType<T> = List<T>;
typedef OutputType = int;

class DailySolver<T> {
  int day;
  late InputType inputData;

  DailySolver({required this.day});

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
  Future<OutputType> solve({required int part}) =>
      throw MissingImplementation();
}
