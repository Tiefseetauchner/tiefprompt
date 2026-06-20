import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_freemium.dart';
import 'package:tiefprompt/services/script_service.dart';

import 'mock_database_managers.dart';

class MockApp extends StatelessWidget {
  final Widget child;
  final ScriptService? scriptOverride;
  final Locale locale;
  final ThemeData? theme;

  const MockApp({
    super.key,
    required this.child,
    required this.locale,
    this.scriptOverride,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final supportedLocales = kSupportedLocales.map((l10n) => l10n.$2).toList();
    final db = createSeededDatabase();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return FutureBuilder(
      future: db,
      builder: (context, snapshot) => ProviderScope(
        overrides: [
          appDatabaseManagerProvider.overrideWith(
            () => MockAppDatabaseManager(snapshot.data!),
          ),
          featuresProvider.overrideWith(() => FeaturesFreemium()),
        ],
        child: EasyLocalization(
          saveLocale: false,
          supportedLocales: supportedLocales,
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          startLocale: locale,
          child: Builder(
            builder: (context) => MaterialApp(
              debugShowCheckedModeBanner: false,
              supportedLocales: supportedLocales,
              locale: locale,
              localizationsDelegates: context.localizationDelegates,
              home: child,
              theme:
                  theme ??
                  ThemeData.from(
                    colorScheme: ColorScheme.light(
                      primary: Color.fromARGB(255, 77, 103, 214),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
