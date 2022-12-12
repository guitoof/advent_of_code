import '../../utils/daily_solver.dart';
import '../../utils/data_source.dart';

class DailySolver7 extends DailySolver<String, int> with FileSystemAnalyzer {
  DailySolver7({required super.day, required super.part});

  @override
  String lineParser(String line) => line;

  @override
  Future<void> loadInputData({required DataSourceType ofType}) async {
    await super.loadInputData(ofType: ofType);
  }

  @override
  Future<int> solve({DataSourceType forType = DataSourceType.challenge}) async {
    await loadInputData(ofType: forType);

    final root = reconstructSystem();
    final minSizeDirectories = getDirectoriesOfMinSize(
      directory: root,
      threshold: 100000,
    );
    return minSizeDirectories.fold<int>(
        0, (sum, directory) => sum + directory.size);
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

mixin FileSystemAnalyzer on DailySolver<String, int> {
  List<Directory> getDirectoriesOfMinSize({
    required Directory directory,
    required int threshold,
  }) {
    final directories = <Directory>[];
    for (final entity in directory.entities) {
      if (entity is Directory) {
        if (entity.size < threshold) {
          directories.add(entity);
        }
        directories.addAll(getDirectoriesOfMinSize(
          directory: entity,
          threshold: threshold,
        ));
      }
    }
    return directories;
  }

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
