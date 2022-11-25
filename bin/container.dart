import 'package:bosun/bosun.dart';

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
