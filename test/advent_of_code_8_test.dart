import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../src/advent_of_code_8/advent_of_code_8.dart';

void main() {
  const simpleInput = <List<List<String>>>[
    [
      [
        'acedgfb',
        'cdfbe',
        'gcdfa',
        'fbcad',
        'dab',
        'cefabd',
        'cdfgeb',
        'eafb',
        'cagedb',
        'ab'
      ],
      ['cdfeb', 'fcadb', 'cdfeb', 'cdbaf']
    ]
  ];
  const largerInput = <List<List<String>>>[
    [
      [
        'be',
        'cfbegad',
        'cbdgef',
        'fgaecd',
        'cgeb',
        'fdcge',
        'agebfd',
        'fecdb',
        'fabcd',
        'edb'
      ],
      ['fdgacbe', 'cefdb', 'cefbgd', 'gcbe']
    ],
    [
      [
        'edbfga',
        'begcd',
        'cbg',
        'gc',
        'gcadebf',
        'fbgde',
        'acbgfd',
        'abcde',
        'gfcbed',
        'gfec'
      ],
      ['fcgedb', 'cgb', 'dgebacf', 'gc']
    ],
    [
      [
        'fgaebd',
        'cg',
        'bdaec',
        'gdafb',
        'agbcfd',
        'gdcbef',
        'bgcad',
        'gfac',
        'gcb',
        'cdgabef'
      ],
      ['cg', 'cg', 'fdcagb', 'cbg']
    ],
    [
      [
        'fbegcd',
        'cbd',
        'adcefb',
        'dageb',
        'afcb',
        'bc',
        'aefdc',
        'ecdab',
        'fgdeca',
        'fcdbega'
      ],
      ['efabcd', 'cedba', 'gadfec', 'cb']
    ],
    [
      [
        'aecbfdg',
        'fbg',
        'gf',
        'bafeg',
        'dbefa',
        'fcge',
        'gcbea',
        'fcaegb',
        'dgceab',
        'fcbdga'
      ],
      ['gecf', 'egdcabf', 'bgf', 'bfgea']
    ],
    [
      [
        'fgeab',
        'ca',
        'afcebg',
        'bdacfeg',
        'cfaedg',
        'gcfdb',
        'baec',
        'bfadeg',
        'bafgc',
        'acf'
      ],
      ['gebdcfa', 'ecba', 'ca', 'fadegcb']
    ],
    [
      [
        'dbcfg',
        'fgd',
        'bdegcaf',
        'fgec',
        'aegbdf',
        'ecdfab',
        'fbedc',
        'dacgb',
        'gdcebf',
        'gf'
      ],
      ['cefg', 'dcbef', 'fcge', 'gbcadfe']
    ],
    [
      [
        'bdfegc',
        'cbegaf',
        'gecbf',
        'dfcage',
        'bdacg',
        'ed',
        'bedf',
        'ced',
        'adcbefg',
        'gebcd'
      ],
      ['ed', 'bcgafe', 'cdgba', 'cbgef']
    ],
    [
      [
        'egadfb',
        'cdbfeg',
        'cegd',
        'fecab',
        'cgb',
        'gbdefca',
        'cg',
        'fgcdab',
        'egfdb',
        'bfceg'
      ],
      ['gbdfcae', 'bgc', 'cg', 'cgb']
    ],
    [
      [
        'gcafb',
        'gcf',
        'dcaebfg',
        'ecagb',
        'gf',
        'abcdeg',
        'gaef',
        'cafbge',
        'fdbac',
        'fegbdc'
      ],
      ['fgae', 'cfgab', 'fg', 'bagce']
    ],
  ];

  group('SevenSegmentMapping', () {
    final mapping = SevenSegmentsMapping.fromPatterns(simpleInput.first.first);
    test('should hold the mapping: "deafgbc"', () {
      expect(
          mapping.toString(),
          equals(
            SevenSegmentsMapping(
                    a: 'd', b: 'e', c: 'a', d: 'f', e: 'g', f: 'b', g: 'c')
                .toString(),
          ));
    });

    [
      'cagedb',
      'ab',
      'gcdfa',
      'fbcad',
      'eafb',
      'cdfbe',
      'cdfgeb',
      'dab',
      'acedgfb',
      'cefabd',
    ].asMap().forEach((index, expectedPattern) =>
        test('should return the pattern for the digit: $index', () {
          final signals = mapping.patterns[index]!.split('');
          signals.sort();
          final expectedSignals = expectedPattern.split('');
          expectedSignals.sort();
          expect(signals, expectedSignals);
        }));
  });

  group('countSimpleDigits', () {
    test('should return the number of 1, 4, 7 or 8', () {
      expect(countSimpleDigits(largerInput), 26);
    });
  });

  group('sumAllDecodedOutputValues', () {
    test('should return the sum of all decoded values provided in the input',
        () {
      expect(sumAllDecodedOutputValues(largerInput), 61229);
    });
  });
}
