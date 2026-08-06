import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/home_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../fake_providers/features_fake_pro.dart';
import '../../fake_providers/script_fake.dart';
import '../../fake_providers/features_fake_free.dart';
import '../../fake_providers/settings_fake.dart';
import '../../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('Marketing Tablet', name: "Home Screen")
Future<ScenarioHarness> buildHomeScreenHarness() async {
  final harness = prepareScreenshotHarness(appContent: const HomeScreen());

  harness.addScenario(
    Scenario(
      name: "Foss",
      providerScopeBuilder: (child) async => ProviderScope(child: child),
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
      name: "Foss Popup",
      providerScopeBuilder: (child) async => ProviderScope(child: child),
      testCallback: (tester, binding) async {
        final variationButtonFinder = find.byKey(
          const Key("HomeScreen.ElevatedButton_FeaturePopup"),
        );

        await tester.tap(variationButtonFinder);
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Freemium Free Popup",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFakeFree())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        final variationButtonFinder = find.byKey(
          const Key("HomeScreen.ElevatedButton_FeaturePopup"),
        );

        await tester.tap(variationButtonFinder);
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Freemium Pro Popup",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFakePro())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        final variationButtonFinder = find.byKey(
          const Key("HomeScreen.ElevatedButton_FeaturePopup"),
        );

        await tester.tap(variationButtonFinder);
        await tester.pumpAndSettle();
      },
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
        ],
        child: child,
      ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Loaded Script",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
            ),
          ),
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

  harness.addScenario(
    Scenario(
      name: "Teal Primary",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(appPrimaryColor: kMarketingTealPrimaryColor),
            ),
          ),
        ],
        child: child,
      ),
    ),
  );

  return harness;
}

@RegisterHarness('Marketing Wide Tablet', name: "Home Screen Wide")
Future<ScenarioHarness> buildHomeScreenWideHarness() async {
  final harness = prepareLandscapeScreenshotHarness(
    appContent: const HomeScreen(),
  );

  harness.addScenario(
    Scenario(
      name: "Foss",
      providerScopeBuilder: (child) async => ProviderScope(child: child),
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
        ],
        child: child,
      ),
    ),
  );

  return harness;
}

@RegisterHarness('Marketing Tablet', name: "Home Screen Highlights")
Future<ScenarioHarness> buildHomeScreenWithHighlightsHarness() async {
  final harness = prepareScreenshotHarness(appContent: const HomeScreen());

  harness.addScenario(
    Scenario(
      name: "Settings",
      providerScopeBuilder: (child) async => ProviderScope(child: child),
      testCallback: (tester, binding) async => await WidgetHighlighter(
        tester,
        defaultHighlightColor: kMarketingHighlightColor,
      ).highlightWidget(find.byTooltip("Settings")),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Title Box",
      testCallback: (tester, binding) async {
        final titleBoxFinder = find.byKey(const Key("HomeScreen.TitleField"));

        await tester.tap(titleBoxFinder);
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(titleBoxFinder);
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Content Box",
      testCallback: (tester, binding) async {
        final contentBoxFinder = find.byKey(const Key("HomeScreen.TextField"));

        await tester.tap(contentBoxFinder);
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(contentBoxFinder);
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Start Button",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
            ),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) async {
        final startButtonFinder = find.byKey(
          const Key("HomeScreen.ElevatedButton_Start"),
        );

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(startButtonFinder);
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Save Button",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
            ),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) async {
        final saveButtonFinder = find.byKey(
          const Key("HomeScreen.ElevatedButton_Save"),
        );

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(saveButtonFinder);
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Save Dialog",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
            ),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("HomeScreen.ElevatedButton_Save")),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Primary Buttons",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
            ),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidgets([
          find.byKey(const Key("HomeScreen.ElevatedButton_Start")),
          find.byKey(const Key("HomeScreen.ElevatedButton_Select")),
          find.byKey(const Key("HomeScreen.ElevatedButton_Save")),
        ], padding: 8);
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Select Script Button",
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(const Key("HomeScreen.ElevatedButton_Select")),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Variant Highlight",
      providerScopeBuilder: (child) async => ProviderScope(child: child),
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(const Key("HomeScreen.ElevatedButton_FeaturePopup")),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Variant Popup",
      providerScopeBuilder: (child) async => ProviderScope(child: child),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("HomeScreen.ElevatedButton_FeaturePopup")),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  return harness;
}
