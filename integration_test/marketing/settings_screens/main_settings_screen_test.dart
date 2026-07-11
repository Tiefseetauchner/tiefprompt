import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_foss.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/settings/settings_screen.dart';

import '../../fake_providers/settings_fake.dart';
import '../../mock_database_managers.dart';
import '../../scenarios/scenario.dart';

Future<void> main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final ref = ProviderContainer();
  AppDatabase db = await createSeededDatabase();

  setUpAll(() async {
    await EasyLocalization.ensureInitialized();
  });

  runScenario(
    "Main Settings Screen Default Language Highlight",
    screenName: "main_settings_screen_light",
    caseName: "default_language_highlighted",
    appContent: SettingsScreen(),
    binding: binding,
    ref: ref,
    widgetHighlighter: (tester) => highlightWidget(
      tester,
      find.byKey(
        const Key("SettingsScreen.DropdownAppSetting_DefaultLanguage"),
      ),
    ),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
        featuresProvider.overrideWith(() => FeaturesFoss()),
      ],
      child: child,
    ),
  );

  runScenario(
    "Main Settings Screen App Theme Highlight",
    screenName: "main_settings_screen_light",
    caseName: "theme_highlighted",
    appContent: SettingsScreen(),
    binding: binding,
    ref: ref,
    widgetHighlighter: (tester) => highlightWidget(
      tester,
      find.byKey(const Key("SettingsScreen.DropdownAppSetting_Theme")),
    ),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
        featuresProvider.overrideWith(() => FeaturesFoss()),
      ],
      child: child,
    ),
  );

  runScenario(
    "Main Settings Screen App Theme Highlight Dark",
    screenName: "main_settings_screen_dark",
    caseName: "theme_highlighted",
    appContent: SettingsScreen(),
    binding: binding,
    ref: ref,
    widgetHighlighter: (tester) => highlightWidget(
      tester,
      find.byKey(const Key("SettingsScreen.DropdownAppSetting_Theme")),
    ),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
        featuresProvider.overrideWith(() => FeaturesFoss()),
        settingsProvider.overrideWith(
          () => SettingsFake(SettingsState(themeMode: ThemeMode.dark)),
        ),
      ],
      child: child,
    ),
  );

  tearDownAll(() async {
    await uploadScreenshots(ref);
  });
}
