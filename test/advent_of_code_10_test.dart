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
  group('getCompletionSequences', () {
    test('should the missing closing characters to complete the line', () {
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
      expect(getCompletionSequences(input),
          ['}}]])})]', ')}>]})', '}}>}>))))', ']]}}]}]}>', '])}>']);
    });
  });

  group('getClosingSequenceScore', () {
    test('should return the closing sequence score', () {
      Input input = ['}}]])})]', ')}>]})', '}}>}>))))', ']]}}]}]}>', '])}>'];
      expect(input.map(getClosingSequenceScore),
          equals([288957, 5566, 1480781, 995444, 294]));
    });
  });

  group('getMissingSequencesScore', () {
    test('should return the score middle score of all closing sequence scores',
        () {
      Input sequence = ['}}]])})]', ')}>]})', '}}>}>))))', ']]}}]}]}>', '])}>'];
      expect(getMissingSequencesScore(sequence), 288957);
    });
  });

  group('getAutocompleteScore', () {
    test('should return the score middle score of all closing sequence scores',
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
      expect(getAutocompleteScore(input), 288957);
    });
  });
}
