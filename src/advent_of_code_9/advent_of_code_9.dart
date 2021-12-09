typedef Input = List<List<int>>;

int sumMinHeights(Input input) {
  int sum = 0;
  for (var i = 0; i < input.length; i++) {
    for (var j = 0; j < input[i].length; j++) {
      if ((i < input.length - 1 ? input[i][j] < input[i + 1][j] : true) &&
          (i > 0 ? input[i][j] < input[i - 1][j] : true) &&
          (j < input[i].length - 1 ? input[i][j] < input[i][j + 1] : true) &&
          (j > 0 ? input[i][j] < input[i][j - 1] : true)) {
        sum += 1 + input[i][j];
      }
    }
  }
  return sum;
}
