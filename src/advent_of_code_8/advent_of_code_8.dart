int countSimpleDigits(List<List<List<String>>> input) {
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
