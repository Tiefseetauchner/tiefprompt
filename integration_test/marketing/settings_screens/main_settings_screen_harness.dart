import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_foss.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/settings/settings_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../fake_providers/settings_fake.dart';
import '../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('MarketingTablet')
Future<ScenarioHarness> buildSettingsHarness() async {
  final harness = prepareScreenshotHarness(
    "Main Settings Screen",
    screenshotManager: ScreenshotManager(serverPort: 3824),
    appContent: SettingsScreen(),
  );

  harness.addScenario(
    Scenario(
      name: "Light Theme",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Default Language Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(
              const Key("SettingsScreen.DropdownAppSetting_DefaultLanguage"),
            ),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "App Theme Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(const Key("SettingsScreen.DropdownAppSetting_Theme")),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "App Theme Highlight Dark",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          featuresProvider.overrideWith(() => FeaturesFoss()),
          settingsProvider.overrideWith(
            () => SettingsFake(SettingsState(themeMode: ThemeMode.dark)),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(const Key("SettingsScreen.DropdownAppSetting_Theme")),
          ),
    ),
  );

  return harness;
}
