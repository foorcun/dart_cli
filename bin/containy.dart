import 'package:bosun/bosun.dart';
import 'package:containy/containy.dart' as containy;

import 'container.dart';

void main(List<String> arguments) {
  execute(
      BosunCommand(
        'containy',
        subcommands: [ContainerCommand(), ReadFile(), WriteFile()],
      ),
      arguments);
}
