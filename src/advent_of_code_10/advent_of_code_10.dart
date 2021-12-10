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

int getSyntaxCheckerScore(Input input) {
  final illegalChars = <String>[];
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
        break;
      }
    }
  }
  return getIllegalCharactersScore(illegalChars);
}
