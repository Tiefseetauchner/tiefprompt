import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_foss.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/home_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../fake_providers/features_fake_pro.dart';
import '../../fake_providers/script_fake.dart';
import '../../fake_providers/features_fake_free.dart';
import '../../fake_providers/settings_fake.dart';
import '../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('MarketingTablet')
Future<ScenarioHarness> buildHomeScreenHarness() async {
  final harness = prepareScreenshotHarness(
    "Home Screen",
    screenshotManager: ScreenshotManager(serverPort: 3824),
    appContent: const HomeScreen(),
  );

  harness.addScenario(
    Scenario(
      name: "Foss",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Freemium Free",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFakeFree())],
        child: child,
      ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Freemium Pro",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFakePro())],
        child: child,
      ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Settings Highlighted",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) => WidgetHighlighter(
        tester,
        defaultHighlightColor: kMarketingHighlightColor,
      ).highlightWidget(find.byTooltip("Settings")),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Prefilled",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
            ),
          ),
          featuresProvider.overrideWith(() => FeaturesFoss()),
        ],
        child: child,
      ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Dark Prefilled",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
            ),
          ),
          featuresProvider.overrideWith(() => FeaturesFoss()),
          settingsProvider.overrideWith(
            () => SettingsFake(SettingsState(themeMode: ThemeMode.dark)),
          ),
        ],
        child: child,
      ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Dark Pink Primary",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          featuresProvider.overrideWith(() => FeaturesFoss()),
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
    ),
  );

  return harness;
}
