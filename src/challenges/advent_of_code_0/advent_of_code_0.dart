import '../../utils/data_source.dart';

Future<List<String>> getInputData0() {
  return getInputData<String>(
    day: 0,
    part: 1,
    lineParser: (String line) => line,
  );
}

Future<bool> computeAnswer() async {
  final rawInput = await getInputData0();
  return true;
}
