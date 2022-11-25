import 'package:bosun/bosun.dart';
import 'dart:io';

class ContainerCommand extends Command {
  ContainerCommand()
      : super(
            command: 'container',
            aliases: ['containers', 'c'],
            description:
                'used for scoping following commands to container functionality',
            example: 'containy container --env=prod',
            subcommands: [ContainerListCommand(), ContainerLogCommand()],
            supportedFlags: {
              'env': 'the environment to query containers against'
            });

  @override
  void run(List<String> args, Map<String, dynamic> flags) {
    // TODO: implement run
    print('Do something with containers in ${flags['env'] ?? 'local'}');
  }
}

class ContainerListCommand extends Command {
  ContainerListCommand()
      : super(command: 'list', description: 'list all containers', aliases: [
          'l'
        ], supportedFlags: {
          'env': 'the environment that you want search for containers'
        });

  @override
  void run(List<String> args, Map<String, dynamic> flags) {
    // TODO: implement run
    print('''
Containers in ${flags['env'] ?? 'local'};
Container abc123
Container def456
''');
  }
}

class ContainerLogCommand extends Command {
  ContainerLogCommand()
      : super(
            command: 'log',
            aliases: ['logs'],
            description: 'show logs for a given container',
            supportedFlags: {
              'env': 'the environment that you want search for containers'
            });

  @override
  void run(List<String> args, Map<String, dynamic> flags) {
    if (args.isEmpty) {
      throw Exception('Must provide an argument to show logs');
    }

    print('''Logs for ${args[0]} in ${flags['env'] ?? 'local'}:
    incoming http request
    request failed with 401 
''');
  }
}

// https://www.youtube.com/watch?v=5I1rPSG4Vz4&ab_channel=YogiCoder
class ReadFile extends Command {
  ReadFile()
      : super(
            command: 'read',
            aliases: ['r'],
            description: 'file daki yaziyi print eder');

  @override
  void run(List<String> args, Map<String, dynamic> flags) {
    new File('yaz_file.txt').readAsString().then((String contents) {
      print(contents);
    });
  }
}

class WriteFile extends Command {
  WriteFile() : super(command: 'write', aliases: ['w']);

  final fileName = 'yaz_file.txt';

  @override
  void run(List<String> args, Map<String, dynamic> flags) async {
    if (!args.isEmpty && args[0] == 'run') {
      var file = File(fileName);
      List<String> lineList = readAsLinesSync(file);

      int lineNumber = -1;
      for (int i = 0; i < lineList.length; i++) {
        if (lineList[i] == "void main()") lineNumber = i;
      }

      if (lineNumber == -1) throw Exception("void main() bulunamadi...");

      // bulunan lineNumbera gore run kodunun eklenmesi
      // print('line number is : $lineNumber');
      if (lineNumber > 0 &&
          lineList[lineNumber - 1] !=
              '''// flutter run -d chrome --web-hostname localhost --web-port 5000 --no-sound-null-safety''') {
        lineList.insert(lineNumber,
            '''// flutter run -d chrome --web-hostname localhost --web-port 5000 --no-sound-null-safety''');
      }

      await file.writeAsString(lineList.join('\n'));
      read(file);
      return;
    }
    new File(fileName)
        // .writeAsString('I am  writing automaticly')
        .writeAsString('I am  writing automaticly bea\n', mode: FileMode.append)
        .then((File file) => read(file));
  }

  read(File file) {
    file.readAsString().then((String contents) {
      print(contents);
    });
  }

//https://www.youtube.com/watch?v=OIj5T7ULBL4&ab_channel=JohanJurrius
  List<String> readAsLinesSync(File file) {
    List<String> lines = file.readAsLinesSync();
    return lines;
  }
}
