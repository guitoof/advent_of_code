typedef Input = List<String>;

class ChunkSeparator {
  final String openingChar;
  final String closingChar;

  const ChunkSeparator(this.openingChar, this.closingChar);
}

const _kSupportedChunkSeparators = [
  ChunkSeparator('(', ')'),
  ChunkSeparator('[', ']'),
  ChunkSeparator('{', '}'),
  ChunkSeparator('<', '>')
];

bool isOpeningChar(String char) {
  assert(char.length == 1);
  return _kSupportedChunkSeparators
      .any((chunkSeparator) => chunkSeparator.openingChar == char);
}

bool isClosingChar(String char) {
  assert(char.length == 1);
  return _kSupportedChunkSeparators
      .any((chunkSeparator) => chunkSeparator.closingChar == char);
}

String getExpectedClosingChar(String openingChar) {
  assert(openingChar.length == 1);
  return _kSupportedChunkSeparators
      .firstWhere((chunkSeparator) => chunkSeparator.openingChar == openingChar)
      .closingChar;
}

int getIllegalCharacterScore(String illegalCharacter) {
  assert(isClosingChar(illegalCharacter));
  switch (illegalCharacter) {
    case ')':
      return 3;
    case ']':
      return 57;
    case '}':
      return 1197;
    case '>':
      return 25137;
    default:
      return 0;
  }
}

int getIllegalCharactersScore(List<String> illegalCharacters) =>
    illegalCharacters.fold(
        0,
        (score, illegalCharacter) =>
            score + getIllegalCharacterScore(illegalCharacter));

int getMissingClosingCharacter(String closingCharacter) {
  switch (closingCharacter) {
    case ')':
      return 1;
    case ']':
      return 2;
    case '}':
      return 3;
    case '>':
      return 4;
    default:
      return 0;
  }
}

int getClosingSequenceScore(String closingSequence) => closingSequence
    .split('')
    .fold(0, (score, char) => 5 * score + getMissingClosingCharacter(char));

int getMissingSequencesScore(List<String> missingSequences) {
  final missingSequencesScores =
      missingSequences.map(getClosingSequenceScore).toList();
  missingSequencesScores.sort();
  return missingSequencesScores[
      (missingSequencesScores.length / 2).round() - 1];
}

int getAutocompleteScore(List<String> input) =>
    getMissingSequencesScore(getSyntaxErrors(input).missingSequences);

class SyntaxErrors {
  final List<String> illegalChars;
  final List<String> missingSequences;

  const SyntaxErrors(
      {required this.illegalChars, required this.missingSequences});
}

SyntaxErrors getSyntaxErrors(Input input) {
  final illegalChars = <String>[];
  final missingSequences = <String>[];
  for (var line in input) {
    final openingChars = [];
    for (var char in line.split('')) {
      if (isOpeningChar(char)) {
        openingChars.add(char);
        continue;
      }
      if (openingChars.isEmpty) break;
      if (isClosingChar(char)) {
        final expectedNextClosingChar =
            getExpectedClosingChar(openingChars.last);
        if (char == expectedNextClosingChar) {
          openingChars.removeLast();
          continue;
        }
        illegalChars.add(char);
        openingChars.clear();
        break;
      }
    }
    if (openingChars.isNotEmpty) {
      missingSequences.add(
        openingChars.reversed
            .map((openingChar) => _kSupportedChunkSeparators
                .firstWhere((chunkSeparator) =>
                    openingChar == chunkSeparator.openingChar)
                .closingChar)
            .join(),
      );
    }
  }
  return SyntaxErrors(
      illegalChars: illegalChars, missingSequences: missingSequences);
}

int getSyntaxCheckerScore(Input input) {
  return getIllegalCharactersScore(getSyntaxErrors(input).illegalChars);
}

List<String> getCompletionSequences(Input input) {
  return getSyntaxErrors(input).missingSequences;
}
