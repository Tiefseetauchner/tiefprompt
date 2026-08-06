import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/settings/settings_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../fake_providers/settings_fake.dart';
import '../../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('Marketing Tablet', name: "Main Settings Screen")
Future<ScenarioHarness> buildSettingsHarness() async {
  final harness = prepareScreenshotHarness(appContent: SettingsScreen());

  harness.addScenario(Scenario(name: "Light Theme"));

  harness.addScenario(
    Scenario(
      name: "Default Language Highlight",
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
      name: "Change Language",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.descendant(
            of: find.byKey(
              const Key("SettingsScreen.DropdownAppSetting_DefaultLanguage"),
            ),
            matching: find.byType(DropdownButton<Locale>),
          ),
        );
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.ancestor(
            of: find.text("Deutsch").first,
            matching: find.byType(DropdownMenuItem<Locale>),
          ),
          padding: 8,
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "German",
      testCallback: (tester, binding) async {
        final context = tester.element(find.byType(SettingsScreen));
        await context.setLocale(const Locale("de", "DE"));
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Change Theme",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.descendant(
            of: find.byKey(
              const Key("SettingsScreen.DropdownAppSetting_Theme"),
            ),
            matching: find.byType(DropdownButton<ThemeMode>),
          ),
        );
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.ancestor(
            of: find.text("Dark").first,
            matching: find.byType(DropdownMenuItem<ThemeMode>),
          ),
          padding: 8,
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Dark Theme Open",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          settingsProvider.overrideWith(
            () => SettingsFake(SettingsState(themeMode: ThemeMode.dark)),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.descendant(
            of: find.byKey(
              const Key("SettingsScreen.DropdownAppSetting_Theme"),
            ),
            matching: find.byType(DropdownButton<ThemeMode>),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "App Theme Highlight",
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

  harness.addScenario(
    Scenario(
      name: "Display Settings Highlight",
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(const Key("SettingsScreen.DisplaySettings")),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Text Settings Highlight",
      testCallback: (tester, binding) => WidgetHighlighter(
        tester,
        defaultHighlightColor: kMarketingHighlightColor,
      ).highlightWidget(find.byKey(const Key("SettingsScreen.TextSettings"))),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Keybindings Highlight",
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(const Key("SettingsScreen.KeybindingsSettings")),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Save And Restore Highlight",
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(const Key("SettingsScreen.SettingsRestore")),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Primary Color Highlight",
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(
              const Key("SettingsScreen.ColorAppSetting_AppPrimaryColor"),
            ),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Primary Color Picker",
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
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key("SettingsScreen.ColorAppSetting_AppPrimaryColor"),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  return harness;
}
