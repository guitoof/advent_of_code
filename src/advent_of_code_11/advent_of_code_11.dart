typedef Input = List<List<int>>;

const _flashThreshold = 9;

class OctopusSquad {
  late List<List<int>> _octopuses;
  List<List<int>> _flashed = [];

  OctopusSquad({required octopuses}) {
    _octopuses = List.from(octopuses.map((line) => List<int>.from(line)));
  }

  int get sum => _octopuses.fold<int>(0,
      (count, line) => count + line.fold(0, (count, value) => count + value));

  void boostAll() {
    for (var i = 0; i < _octopuses.length; i++) {
      for (var j = 0; j < _octopuses[i].length; j++) {
        _octopuses[i][j]++;
      }
    }
  }

  void boostNeighbours({required int x, required int y}) {
    final radius = 1;
    for (var i = y - radius; i <= y + radius; i++) {
      for (var j = x - radius; j <= x + radius; j++) {
        if ((i == y && j == x) ||
            i < 0 ||
            i > _octopuses.length - 1 ||
            j < 0 ||
            j > _octopuses[i].length - 1) {
          continue;
        }
        if (_octopuses[i][j] > _flashThreshold) {
          continue;
        }
        _octopuses[i][j]++;
      }
    }
    for (var i = y - radius; i <= y + radius; i++) {
      for (var j = x - radius; j <= x + radius; j++) {
        if ((i == y && j == x) ||
            i < 0 ||
            i > _octopuses.length - 1 ||
            j < 0 ||
            j > _octopuses[i].length - 1) {
          continue;
        }
        if (_octopuses[i][j] > _flashThreshold &&
            !_flashed.any((position) => position[0] == i && position[1] == j)) {
          _flashed.add([i, j]);
          boostNeighbours(x: j, y: i);
        }
      }
    }
  }

  void flash() {
    for (var i = 0; i < _octopuses.length; i++) {
      for (var j = 0; j < _octopuses[i].length; j++) {
        if (_octopuses[i][j] > _flashThreshold &&
            !_flashed.any((position) => position[0] == i && position[1] == j)) {
          _flashed.add([i, j]);
          boostNeighbours(x: j, y: i);
        }
      }
    }
    reset();
  }

  void reset() {
    for (var position in _flashed) {
      _octopuses[position[0]][position[1]] = 0;
    }
    _flashed = [];
  }

  int countFlashed() {
    return _octopuses.fold<int>(
        0,
        (count, line) =>
            count +
            line.fold(0, (count, value) => count + (value == 0 ? 1 : 0)));
  }

  int nextStep() {
    boostAll();
    flash();
    return countFlashed();
  }
}

int countOctopusFlashes(Input input, {required int steps}) {
  final octopusSquad = OctopusSquad(octopuses: input);
  return [for (var step = 1; step <= steps; step++) step]
      .fold(0, (flashesCount, _) => flashesCount + octopusSquad.nextStep());
}

int firstSyncFlash(Input input) {
  final octopusSquad = OctopusSquad(octopuses: input);
  var steps = 0;
  while (octopusSquad.sum > 0) {
    steps++;
    octopusSquad.nextStep();
  }
  return steps;
}
