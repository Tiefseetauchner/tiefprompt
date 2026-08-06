import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/providers/prompter_config.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/settings/text_settings_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../fake_providers/settings_fake.dart';
import '../../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('Marketing Tablet', name: "Text Settings Screen")
Future<ScenarioHarness> buildTextSettingsHarness() async {
  final harness = prepareScreenshotHarness(
    appContent: const TextSettingsScreen(),
  );

  harness.addScenario(Scenario(name: "Light Theme"));

  harness.addScenario(
    Scenario(
      name: "Default Font Size Highlight",
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(
              const Key("TextSettingsScreen.NumberAppSetting_FontSize"),
            ),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Default Font Size Dialog",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("TextSettingsScreen.NumberAppSetting_FontSize")),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Text Alignment Highlight",
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(
              const Key("TextSettingsScreen.DropdownAppSetting_TextAlignment"),
            ),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Text Alignment Open",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.descendant(
            of: find.byKey(
              const Key("TextSettingsScreen.DropdownAppSetting_TextAlignment"),
            ),
            matching: find.byType(DropdownButton<TextAlign>),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Font Family Highlight",
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(
              const Key("TextSettingsScreen.DropdownAppSetting_FontFamily"),
            ),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Font Family Open",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.descendant(
            of: find.byKey(
              const Key("TextSettingsScreen.DropdownAppSetting_FontFamily"),
            ),
            matching: find.byType(DropdownButton<String>),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Custom Fonts Highlight",
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(
              const Key("TextSettingsScreen.LinkAppSetting_CustomFonts"),
            ),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Enable Markdown Highlight",
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(
              const Key("TextSettingsScreen.BooleanAppSetting_Markdown"),
            ),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Show Current Chapter Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(markdownEnabled: true),
              ),
            ),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(
              const Key(
                "TextSettingsScreen.BooleanAppSetting_ShowCurrentChapter",
              ),
            ),
          ),
    ),
  );

  return harness;
}
