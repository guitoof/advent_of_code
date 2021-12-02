import '../src/advent_of_code_x.dart';
import '../src/utils/data_source.dart';

void main(List<String> arguments) async {
  final input = await getInputData(id: 1);
  print('The answer is: ${myFunction(input)}');
}
