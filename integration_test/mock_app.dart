import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:talker/talker.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_foss.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/providers/talker_provider.dart';
import 'package:tiefprompt/services/script_service.dart';
import 'package:tiefprompt/ui/widgets/banner_listener.dart';
import 'package:tiefprompt/ui/widgets/themed_app.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import 'mock_database_managers.dart';

class _MockSettings extends Settings {
  _MockSettings(this._state);

  final SettingsState _state;

  @override
  Future<SettingsState> build() async {
    await super.build();
    return _state;
  }
}

class MockApp extends StatefulWidget {
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
  State<MockApp> createState() => _MockAppState();
}

class _MockAppState extends State<MockApp> {
  late final Future<List<Object>> combinedFuture;

  @override
  void initState() {
    super.initState();

    final supportedLocales = kSupportedLocales.map((l10n) => l10n.$2).toList();

    final app = EasyLocalization(
      saveLocale: false,
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: widget.locale,
      child: Builder(
        builder: (context) => ThemedApp(
          routerConfig: GoRouter(
            initialLocation: '/',
            routes: [
              GoRoute(path: '/', builder: (context, state) => widget.child),
            ],
          ),
          debugShowCheckedModeBanner: false,
          builder: (context, child) =>
              BannerListener(child: child ?? const SizedBox.shrink()),
        ),
      ),
    );

    combinedFuture = Future.wait([
      createSeededDatabase(),
      widget.providerScopeBuilder?.call(app) ?? Future<Widget>.value(app),
    ]);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    combinedFuture.then((values) => (values[0] as AppDatabase).close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: combinedFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        return ProviderScope(
          overrides: [
            appDatabaseManagerProvider.overrideWith(
              () => MockAppDatabaseManager(snapshot.data![0] as AppDatabase),
            ),
            featuresProvider.overrideWith(() => FeaturesFoss()),
            settingsProvider.overrideWith(() => _MockSettings(widget.settings)),
            talkerProvider.overrideWithValue(Talker()),
          ],
          child: snapshot.data![1] as Widget,
        );
      },
    );
  }
}
