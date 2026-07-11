import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_foss.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/home_screen.dart';

import '../../fake_providers/features_fake_pro.dart';
import '../../fake_providers/script_fake.dart';
import '../../fake_providers/features_fake_free.dart';
import '../../fake_providers/settings_fake.dart';
import '../../mock_database_managers.dart';
import '../constants.dart';
import '../../scenarios/scenario.dart';

Future<void> main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final ref = ProviderContainer();
  AppDatabase db = await createSeededDatabase();

  setUpAll(() async {
    await EasyLocalization.ensureInitialized();
  });

  runScenario(
    "Home Screen Foss Empty",
    binding: binding,
    ref: ref,
    screenName: "home_screen_light",
    caseName: "foss",
    appContent: HomeScreen(),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        featuresProvider.overrideWith(() => FeaturesFoss()),
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
      ],
      child: child,
    ),
  );

  runScenario(
    "Home Screen Freemium Free Empty",
    binding: binding,
    ref: ref,
    screenName: "home_screen_light",
    caseName: "freemium_free",
    appContent: HomeScreen(),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        featuresProvider.overrideWith(() => FeaturesFakeFree()),
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
      ],
      child: child,
    ),
  );

  runScenario(
    "Home Screen Freemium Pro Empty",
    binding: binding,
    ref: ref,
    screenName: "home_screen_light",
    caseName: "freemium_pro_empty",
    appContent: HomeScreen(),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        featuresProvider.overrideWith(() => FeaturesFakePro()),
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
      ],
      child: child,
    ),
  );

  runScenario(
    "Home Screen Foss Prefilled",
    binding: binding,
    ref: ref,
    screenName: "home_screen_light",
    caseName: "foss_prefilled",
    appContent: HomeScreen(),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        scriptProvider.overrideWith(
          () => ScriptFake(
            name: kMarketingScriptName,
            content: kMarketingScriptContent,
          ),
        ),
        featuresProvider.overrideWith(() => FeaturesFoss()),
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
      ],
      child: child,
    ),
  );

  runScenario(
    "Home Screen Foss Settings Highlighted",
    binding: binding,
    ref: ref,
    screenName: "home_screen_light",
    caseName: "foss_settings_highlighted",
    appContent: HomeScreen(),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        featuresProvider.overrideWith(() => FeaturesFoss()),
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
      ],
      child: child,
    ),
    widgetHighlighter: (tester) =>
        highlightWidget(tester, find.byTooltip("Settings")),
  );

  runScenario(
    "Home Screen Foss Dark",
    binding: binding,
    ref: ref,
    screenName: "home_screen_dark",
    caseName: "foss",
    appContent: HomeScreen(),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        featuresProvider.overrideWith(() => FeaturesFoss()),
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
        settingsProvider.overrideWith(
          () => SettingsFake(SettingsState(themeMode: ThemeMode.dark)),
        ),
      ],
      child: child,
    ),
  );

  runScenario(
    "Home Screen Foss Dark Pink Primary",
    binding: binding,
    ref: ref,
    screenName: "home_screen_dark",
    caseName: "foss_pink",
    appContent: HomeScreen(),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        featuresProvider.overrideWith(() => FeaturesFoss()),
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
        settingsProvider.overrideWith(
          () => SettingsFake(
            SettingsState(
              themeMode: ThemeMode.dark,
              appPrimaryColor: kMarketingPinkPrimaryColor,
            ),
          ),
        ),
      ],
      child: child,
    ),
  );

  tearDownAll(() async {
    await uploadScreenshots(ref);
  });
}
