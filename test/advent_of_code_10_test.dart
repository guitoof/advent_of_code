import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../src/advent_of_code_10/advent_of_code_10.dart';

void main() {
  group('getSyntaxCheckerScore', () {
    test(
        'should return the summed score of each line\'s illegal character syntax error score',
        () {
      Input input = [
        '[({(<(())[]>[[{[]{<()<>>',
        '[(()[<>])]({[<{<<[]>>(',
        '{([(<{}[<>[]}>{[]{[(<()>',
        '(((({<>}<{<{<>}{[]{[]{}',
        '[[<[([]))<([[{}[[()]]]',
        '[{[{({}]{}}([{[{{{}}([]',
        '{<[[]]>}<{[{[{[]{()[[[]',
        '[<(<(<(<{}))><([]([]()',
        '<{([([[(<>()){}]>(<<{{',
        '<{([{{}}[<[[[<>{}]]]>[]]',
      ];
      expect(getSyntaxCheckerScore(input), 26397);
    });
  });
}
