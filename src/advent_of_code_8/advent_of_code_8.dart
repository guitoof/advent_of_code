import 'dart:math';

typedef Input = List<List<List<String>>>;

class SevenSegmentsMapping {
  String? a;
  String? b;
  String? c;
  String? d;
  String? e;
  String? f;
  String? g;

  SevenSegmentsMapping({
    this.a,
    this.b,
    this.c,
    this.d,
    this.e,
    this.f,
    this.g,
  });

  SevenSegmentsMapping.fromPatterns(List<String> input) {
    inputSignals = input;
    for (var pattern in inputSignals!) {
      registerSimplePattern(pattern);
    }
    updateWiring();
  }

  @override
  String toString() {
    return '''{
      a: $a,
      b: $b,
      c: $c,
      d: $d,
      e: $e,
      f: $f,
      g: $g,
    }''';
  }

  List<String>? inputSignals;
  final List<String?> _patterns = List.generate(10, (index) => null);

  List<String?> get patterns => [
        '$a$b$c$e$f$g', // 0
        '$c$f', // 1
        '$a$c$d$e$g', // 2
        '$a$c$d$f$g', // 3
        '$b$c$d$f', // 4
        '$a$b$d$f$g', // 5
        '$a$b$d$e$f$g', // 6
        '$a$c$f', // 7
        '$a$b$c$d$e$f$g', // 8
        '$a$b$c$d$f$g', // 9
      ];

  static bool match(String pattern1, String pattern2) {
    final signals1 = pattern1.split('');
    final signals2 = pattern2.split('');
    signals1.sort();
    signals2.sort();
    return signals1.join() == signals2.join();
  }

  int decode(String pattern) {
    assert(a != null &&
        b != null &&
        c != null &&
        d != null &&
        e != null &&
        f != null &&
        g != null);
    return patterns.indexWhere((decodedPattern) {
      if (decodedPattern == null) return false;
      return match(pattern, decodedPattern);
    });
  }

  void registerSimplePattern(String pattern) {
    switch (pattern.length) {
      case 2:
        _patterns[1] = pattern;
        break;
      case 4:
        _patterns[4] = pattern;
        break;
      case 3:
        _patterns[7] = pattern;
        break;
      case 7:
        _patterns[8] = pattern;
        break;
    }
  }

  String findPatternFromBase(String base) {
    assert(inputSignals != null);
    return inputSignals!.firstWhere((pattern) {
      if (pattern.length != base.length + 1) return false; // ignore base
      return base.split('').every((X) => pattern.contains(X));
    });
  }

  static String extractCharacter(String largerString, String shorterString) =>
      largerString.split('').where((X) => !shorterString.contains(X)).join();

  void setASegmentWiring() {
    assert(_patterns[1] != null && _patterns[7] != null);
    a = extractCharacter(_patterns[7]!, _patterns[1]!);
  }

  void setGSegmentWiring() {
    assert(_patterns[4] != null && a != null);
    final referencePattern = '${_patterns[4]!}$a';
    _patterns[9] = findPatternFromBase(referencePattern);
    g = extractCharacter(_patterns[9]!, referencePattern);
  }

  void setESegmentWiring() {
    assert(_patterns[9] != null && _patterns[8] != null);
    e = extractCharacter(_patterns[8]!, _patterns[9]!);
  }

  void setDSegmentWiring() {
    assert(_patterns[1] != null && a != null && g != null);
    final referencePattern = '${_patterns[1]!}$a$g';
    _patterns[3] = findPatternFromBase(referencePattern);
    d = extractCharacter(_patterns[3]!, referencePattern);
  }

  void setCSegmentWiring() {
    assert(a != null && d != null && e != null && g != null);
    final referencePattern = '$a$d$e$g';
    _patterns[2] = findPatternFromBase(referencePattern);
    c = extractCharacter(_patterns[2]!, referencePattern);
  }

  void setFSegmentWiring() {
    assert(_patterns[1] != null && c != null);
    f = extractCharacter(_patterns[1]!, c!);
  }

  void setBSegmentWiring() {
    assert(_patterns[4] != null && c != null && d != null && f != null);
    b = extractCharacter(_patterns[4]!, '${c!}${d!}${f!}');
  }

  void updateWiring() {
    setASegmentWiring();
    setGSegmentWiring();
    setESegmentWiring();
    setDSegmentWiring();
    setCSegmentWiring();
    setFSegmentWiring();
    setBSegmentWiring();
  }

  void wireSegments({required int segmentsDigit, required String pattern}) {
    switch (segmentsDigit) {
      case 1:
        c = pattern[0];
        f = pattern[1];
        break;
      case 4:
        b = pattern[0];
        c = pattern[1];
        d = pattern[2];
        f = pattern[3];
        break;
      case 7:
        a = pattern[0];
        c = pattern[1];
        f = pattern[2];
        break;
      case 8:
        c = pattern[0];
        f = pattern[1];
        break;
    }
  }
}

int countSimpleDigits(Input input) {
  return input.fold<int>(0, (count, line) {
    return count +
        line[1].fold<int>(
          0,
          (count, digit) =>
              count +
              ((digit.length == 2 ||
                      digit.length == 4 ||
                      digit.length == 3 ||
                      digit.length == 7)
                  ? 1
                  : 0),
        );
  });
}

int sumAllDecodedOutputValues(Input input) {
  return input.fold<int>(0, (sum, line) {
    final signalPatterns = line[0];
    final mapping = SevenSegmentsMapping.fromPatterns(signalPatterns);

    final outputDigitValues = line[1].where((w) => w != '').toList();
    var value = 0;
    for (var index = 0; index < outputDigitValues.length; index++) {
      value += mapping.decode(outputDigitValues[index]) *
          pow(10, outputDigitValues.length - 1 - index) as int;
    }
    return sum + value;
  });
}
