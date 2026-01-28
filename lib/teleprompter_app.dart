import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tiefprompt/providers/combining_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/router_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/providers/theme_provider.dart';
import 'package:tiefprompt/ui/widgets/banner_listener.dart';

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
      final res = await ref.read(featuresProvider.notifier).bootstrap();

      if (!res) {
        ref.invalidate(featuresProvider);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(
      settingsProvider.select((s) => s.whenData((d) => d.themeMode)),
    );
    final router = ref.watch(tiefPromptRouterProvider);
    final lightTheme = ref.watch(
      themesProvider.select((t) => t.whenData((d) => d.lightTheme)),
    );
    final darkTheme = ref.watch(
      themesProvider.select((t) => t.whenData((d) => d.darkTheme)),
    );
    final combiningProvider = ref.watch(
      combinedAsyncDataProvider.call([themeMode, lightTheme, darkTheme]),
    );

    return switch (combiningProvider) {
      AsyncData(:final value) => MaterialApp.router(
        title: 'Teleprompter',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: router,
        builder: (context, child) =>
            BannerListener(child: child ?? const SizedBox.shrink()),
        theme: value.states[1] as ThemeData,
        darkTheme: value.states[2] as ThemeData,
        themeMode: value.states[0] as ThemeMode,
      ),
      AsyncLoading() => MaterialApp.router(
        title: 'Teleprompter',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: router,
        builder: (context, child) => BannerListener(
          child:
              child ??
              const SizedBox.shrink(
                child: SpinKitRing(color: Color.fromARGB(255, 77, 103, 214)),
              ),
        ),
      ),
      _ => Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Column(
            children: [
              Text(
                "An exceedingly scary error occurred loading the settings or maybe even the themes ( :c ). Do you want to reset them?",
              ),
              ElevatedButton(
                onPressed: () =>
                    ref.read(settingsProvider.notifier).resetSettings(),
                child: Text("Reset Settings"),
              ),
            ],
          ),
        ),
      ),
    };
  }
}
