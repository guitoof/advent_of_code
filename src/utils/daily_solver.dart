import 'data_source.dart';

class MissingImplementation extends Error {}

class UnsupportedCase extends Error {}

typedef InputType<T> = List<T>;
typedef OutputType = int;

class DailySolver<T> {
  int day;
  String name;
  late InputType inputData;

  DailySolver({required this.day, required this.name});

  /// IMPLEMENT
  T lineParser(String line) => throw MissingImplementation();

  /// IMPLEMENT
  /// Must call super.loadInputData
  Future<void> loadInputData({required int part}) async {
    inputData = await getInputData<T>(
      day: day,
      part: part,
      lineParser: lineParser,
    );
  }

  /// IMPLEMENT
  /// Must call super.loadInputData
  Future<OutputType> solve({required int part}) =>
      throw MissingImplementation();
}
