import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/models/keybinding.dart';

part 'commands_provider.g.dart';

enum CommandSource { keybinding, remote, controlButton }

class CommandEvent {
  final CommandAction action;
  final CommandSource source;

  CommandEvent(this.action, this.source);
}

@Riverpod(keepAlive: true)
class Command extends _$Command {
  final StreamController<CommandEvent> _controller =
      StreamController<CommandEvent>.broadcast();

  @override
  void build() {
    ref.onDispose(_controller.close);
  }

  Stream<CommandEvent> get stream => _controller.stream;

  void sendCommandToPrompter(CommandEvent event) {
    _controller.add(event);
  }
}
