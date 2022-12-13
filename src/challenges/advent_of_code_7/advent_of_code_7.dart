import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

class DailySolver7 extends DailySolver<String, int> with FileSystemAnalyzer {
  DailySolver7({required super.day, required super.part});

  @override
  String lineParser(String line) => line;

  @override
  Future<void> loadInputData({required DataSourceType ofType}) async {
    await super.loadInputData(ofType: ofType);

    root = reconstructSystem();
    final system = System(root: root, storageSize: 70000000);
    spaceMaker = SystemSpaceMaker(system: system, targetFreeSpace: 30000000);
  }

  @override
  Future<int> solve({DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);

    switch (part) {
      case 1:
        final minSizeDirectories = SystemSpaceMaker.getDirectoriesOfMinSize(
          directory: root,
          threshold: 100000,
        );
        return minSizeDirectories.fold<int>(
            0, (sum, directory) => sum + directory.size);
      case 2:
        return spaceMaker.getSortedDeletionCandidates().first.size;
      default:
        throw Exception('Unsupported part: $part');
    }
  }
}

abstract class SystemEntity {
  String name;
  SystemEntity? parent;
  late String _path;

  String get type;
  int? get size;

  SystemEntity({required this.name, this.parent}) {
    _path = parent == null ? name : parent!._path + '/' + name;
  }

  @override
  String toString() =>
      '- $name ($type${type != 'dir' ? ', size=$size' : ''})\n';
}

class Directory extends SystemEntity {
  final List<SystemEntity> entities;

  @override
  String get type => 'dir';

  @override
  int get size => entities.fold(0, (sum, entity) => sum + (entity.size ?? 0));

  Directory({
    required super.name,
    super.parent,
    required this.entities,
  });

  SystemEntity? findByName(String entityName) {
    return name == entityName
        ? this
        : entities.fold<SystemEntity?>(null, (found, entity) {
            if (found != null) {
              return found;
            }
            if (entity.name == entityName) {
              return entity;
            }
            if (entity is Directory) {
              return entity.findByName(entityName);
            }
            return null;
          });
  }

  @override
  String toString() => '${super.toString()}'
      '   ${entities.map((e) => e.toString()).toList()}\n';
}

class File extends SystemEntity {
  final int _size;

  @override
  String get type => 'file';

  @override
  int get size => _size;

  File({
    required super.name,
    super.parent,
    required int size,
  }) : _size = size;
}

class System {
  final Directory root;
  final int storageSize;

  int get used => root.size;
  int get free => storageSize - used;

  System({required this.root, required this.storageSize});
}

class SystemSpaceMaker {
  final System system;
  final int targetFreeSpace;

  int get freeSpaceNeeded => targetFreeSpace - system.free;

  SystemSpaceMaker({required this.system, required this.targetFreeSpace});

  List<Directory> getSortedDeletionCandidates() {
    final directories = getAllDirectoriesOfSizedComparedTo(
      comparator: (directory) => directory.size >= freeSpaceNeeded,
    );
    directories.sort((a, b) => a.size.compareTo(b.size));
    return directories;
  }

  List<Directory> getAllDirectoriesOfSizedComparedTo({
    required bool Function(Directory) comparator,
  }) =>
      <Directory>[
        if (comparator(system.root)) system.root,
        ...getDirectoriesOfSizedComparedTo(
          directory: system.root,
          comparator: comparator,
        ),
      ];

  static List<Directory> getDirectoriesOfSizedComparedTo({
    required Directory directory,
    required bool Function(Directory) comparator,
  }) {
    final directories = <Directory>[];
    for (final entity in directory.entities) {
      if (entity is Directory) {
        if (comparator(entity)) {
          directories.add(entity);
        }
        directories.addAll(getDirectoriesOfSizedComparedTo(
          directory: entity,
          comparator: comparator,
        ));
      }
    }
    return directories;
  }

  static List<Directory> getDirectoriesOfMaxSize({
    required Directory directory,
    required int threshold,
  }) {
    return getDirectoriesOfSizedComparedTo(
      directory: directory,
      comparator: (directory) => directory.size < threshold,
    );
  }

  static List<Directory> getDirectoriesOfMinSize({
    required Directory directory,
    required int threshold,
  }) {
    return getDirectoriesOfSizedComparedTo(
      directory: directory,
      comparator: (directory) => directory.size >= threshold,
    );
  }
}

mixin FileSystemAnalyzer on DailySolver<String, int> {
  late Directory root;
  late SystemSpaceMaker spaceMaker;

  int get amountOfFreeSpaceNeeded => spaceMaker.freeSpaceNeeded;

  Directory reconstructSystem() {
    final terminalOutput = inputData;
    Directory? currentDirectory;
    for (var cursor = 0; cursor < terminalOutput.length;) {
      if (terminalOutput[cursor].contains('cd')) {
        final targetDirectory = terminalOutput[cursor].split('cd ')[1];
        if (targetDirectory == '..') {
          final parent = currentDirectory?.parent;
          if (parent == null) {
            throw Exception('Cannot go up from root directory');
          }
          currentDirectory = parent as Directory;
          cursor++;
          continue;
        } else if (currentDirectory?.entities
                .firstWhere((directory) => directory.name == targetDirectory) !=
            null) {
          currentDirectory = currentDirectory?.entities
                  .firstWhere((entity) => entity.name == targetDirectory)
              as Directory;
        } else {
          currentDirectory = Directory(
              name: targetDirectory, parent: currentDirectory, entities: []);
        }
        cursor++;
      } else if (terminalOutput[cursor].contains('ls')) {
        var lsIndex = 1;
        while (cursor + lsIndex < terminalOutput.length &&
            !terminalOutput[cursor + lsIndex].startsWith('\$')) {
          final isDir = terminalOutput[cursor + lsIndex].startsWith('dir');
          final name = isDir
              ? terminalOutput[cursor + lsIndex].split('dir ')[1]
              : terminalOutput[cursor + lsIndex].split(' ')[1];
          final size = terminalOutput[cursor + lsIndex].split(' ')[0];
          currentDirectory?.entities.add(
            isDir
                ? Directory(
                    name: name,
                    parent: currentDirectory,
                    entities: [],
                  )
                : File(
                    name: name,
                    parent: currentDirectory,
                    size: int.parse(size),
                  ),
          );
          lsIndex++;
        }
        cursor += lsIndex;
        continue;
      }
    }

    if (currentDirectory == null) throw Exception('No directory found');

    while (currentDirectory!.parent != null) {
      currentDirectory = currentDirectory.parent! as Directory;
    }

    return currentDirectory;
  }

  String printSystemStructure() {
    final root = reconstructSystem();
    return '''
    $root
    ''';
  }
}
