import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/services/script_service.dart';
import 'package:tiefprompt/ui/widgets/themed_app.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import 'fake_providers/features_fake_free.dart';
import 'mock_database_managers.dart';

class _MockSettings extends Settings {
  _MockSettings(this._state);

  final SettingsState _state;

  @override
  Future<SettingsState> build() async => _state;
}

class MockApp extends StatelessWidget {
  final Widget child;
  final ScriptService? scriptOverride;
  final Locale locale;
  final SettingsState settings;
  final ProviderScopeBuilder? providerScopeBuilder;

  MockApp({
    super.key,
    required this.child,
    required this.locale,
    this.scriptOverride,
    this.providerScopeBuilder,
    SettingsState? settings,
  }) : settings = settings ?? SettingsState();

  @override
  Widget build(BuildContext context) {
    final supportedLocales = kSupportedLocales.map((l10n) => l10n.$2).toList();

    final app = EasyLocalization(
      saveLocale: false,
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: locale,
      child: Builder(
        builder: (context) =>
            ThemedApp(home: child, debugShowCheckedModeBanner: false),
      ),
    );

    final db = createSeededDatabase();
    final combinedFuture = Future.wait([
      db,
      providerScopeBuilder?.call(app) ?? Future<Widget>.value(app),
    ]);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return FutureBuilder(
      future: combinedFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        return ProviderScope(
          overrides: [
            appDatabaseManagerProvider.overrideWith(
              () => MockAppDatabaseManager(snapshot.data![0] as AppDatabase),
            ),
            featuresProvider.overrideWith(() => FeaturesFakeFree()),
            settingsProvider.overrideWith(() => _MockSettings(settings)),
          ],
          child: snapshot.data![1] as Widget,
        );
      },
    );
  }
}
