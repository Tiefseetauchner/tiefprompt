import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/banner_provider.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/router_provider.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/providers/talker_provider.dart';
import 'package:tiefprompt/services/script_service.dart';
import 'package:tiefprompt/ui/widgets/banner_listener.dart';
import 'package:tiefprompt/ui/widgets/themed_app.dart';

class TeleprompterApp extends ConsumerStatefulWidget {
  const TeleprompterApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TeleprompterAppState();
}

class _TeleprompterAppState extends ConsumerState<TeleprompterApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final talker = ref.read(talkerProvider);

      final res = await ref.read(featuresProvider.notifier).bootstrap();

      if (!res) {
        talker.warning(
          'Feature bootstrap returned false - invalidating featuresProvider',
        );
        ref.invalidate(featuresProvider);
      } else {
        talker.info('Feature bootstrap succeeded');
      }

      if (ref
          .watch(featuresProvider)
          .features
          .contains(Feature.ephemeralScript)) {
        final ephemeralScriptsFilter = ref
            .read(databaseManagersProvider)
            .scriptModel
            .filter((f) => f.ephemeral.equals(true));
        final ephemeralScripts = await ephemeralScriptsFilter.get();

        final scriptService = ref.read(scriptServiceProvider.notifier);

        if (ephemeralScripts.isEmpty) {
          talker.info('No ephemeral script found - creating one');
          final newEphemeralScriptId = await scriptService.createEphemeral();
          final newEphemeralScript = await ref
              .read(scriptServiceProvider.notifier)
              .loadScript(newEphemeralScriptId);
          ref.read(scriptProvider.notifier).loadScript(newEphemeralScript);
        } else if (ephemeralScripts.length > 1) {
          talker.error(
            'Multiple ephemeral scripts found (count: ${ephemeralScripts.length}) - resetting',
          );
          if (mounted) {
            ref
                .read(bannerMessageProvider.notifier)
                .set(
                  "Multiple ephemeral scripts were found. Creating empty new ephemeral script. This is a bug in TiefPrompt, please report it to the author.",
                );
          }

          ephemeralScriptsFilter.update((o) => o(ephemeral: Value(false)));
          final newEphemeralScriptId = await scriptService.createEphemeral();
          final newEphemeralScript = await ref
              .read(scriptServiceProvider.notifier)
              .loadScript(newEphemeralScriptId);
          ref.read(scriptProvider.notifier).loadScript(newEphemeralScript);
        } else {
          final ephemeralScript = ephemeralScripts.single;
          talker.info('Ephemeral script loaded: id=${ephemeralScript.id}');
          final scriptProviderNotifier = ref.read(scriptProvider.notifier);
          scriptProviderNotifier.loadScript(ephemeralScript);
          scriptProviderNotifier.setIsSaved(ephemeralScript.scriptText == "");
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemedApp(
      routerConfig: ref.watch(tiefPromptRouterProvider),
      builder: (context, child) => BannerListener(
        child:
            child ??
            const SizedBox.shrink(child: SpinKitRing(color: kBrandTeal)),
      ),
    );
  }
}
