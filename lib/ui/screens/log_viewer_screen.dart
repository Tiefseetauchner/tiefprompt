import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:tiefprompt/providers/talker_provider.dart';

class LogViewerScreen extends ConsumerWidget {
  const LogViewerScreen({super.key});

  @override
  Widget build(context, ref) {
    final talker = ref.read(talkerProvider);

    return TalkerScreen(
      talker: talker,
      theme: TalkerScreenTheme.fromTheme(Theme.of(context)),
    );
  }
}
