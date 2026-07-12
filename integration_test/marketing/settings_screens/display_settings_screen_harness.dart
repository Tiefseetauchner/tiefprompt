import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_foss.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/settings/display_settings_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../fake_providers/settings_fake.dart';
import '../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('MarketingTablet')
Future<ScenarioHarness> buildDisplaySettingsHarness() async {
  final harness = prepareScreenshotHarness(
    "Display Settings Screen",
    screenshotManager: ScreenshotManager(serverPort: 3824),
    appContent: const DisplaySettingsScreen(),
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
    _highlightScenario(
      "Scroll Speed Highlight",
      const Key("DisplaySettingsScreen.NumberAppSetting_ScrollSpeed"),
    ),
  );

  harness.addScenario(
    _tapScenario(
      "Scroll Speed Dialog",
      const Key("DisplaySettingsScreen.NumberAppSetting_ScrollSpeed"),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Flip Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidgets([
            find.byKey(
              const Key("DisplaySettingsScreen.BooleanAppSetting_FlipX"),
            ),
            find.byKey(
              const Key("DisplaySettingsScreen.BooleanAppSetting_FlipY"),
            ),
          ], padding: 4),
    ),
  );

  harness.addScenario(
    _highlightScenario(
      "Control Buttons Enable Highlight",
      const Key("DisplaySettingsScreen.BooleanAppSetting_ControlButtonsEnable"),
    ),
  );

  harness.addScenario(
    _highlightScenario(
      "Control Buttons Position Highlight",
      const Key(
        "DisplaySettingsScreen.DropdownAppSetting_ControlButtonsPosition",
      ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Control Buttons Position Open",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.descendant(
            of: find.byKey(
              const Key(
                "DisplaySettingsScreen.DropdownAppSetting_ControlButtonsPosition",
              ),
            ),
            matching: find.byType(DropdownButton<ControlButtonsPosition>),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    _highlightScenario(
      "Reading Indicators Highlight",
      const Key("DisplaySettingsScreen.BooleanAppSetting_ReadingIndicators"),
    ),
  );

  harness.addScenario(
    _highlightScenario(
      "Reading Indicators Height Highlight",
      const Key(
        "DisplaySettingsScreen.NumberAppSetting_ReadingIndicatorsHeight",
      ),
    ),
  );

  harness.addScenario(
    _tapScenario(
      "Reading Indicators Height Dialog",
      const Key(
        "DisplaySettingsScreen.NumberAppSetting_ReadingIndicatorsHeight",
      ),
    ),
  );

  harness.addScenario(
    _highlightScenario(
      "Vertical Margins Enable Highlight",
      const Key(
        "DisplaySettingsScreen.BooleanAppSetting_VerticalMarginsEnable",
      ),
      scrollToBottom: true,
    ),
  );

  harness.addScenario(
    _highlightScenario(
      "Vertical Margins Height Highlight",
      const Key("DisplaySettingsScreen.NumberAppSetting_VerticalMarginsHeight"),
      scrollToBottom: true,
    ),
  );

  harness.addScenario(
    _tapScenario(
      "Vertical Margins Height Dialog",
      const Key("DisplaySettingsScreen.NumberAppSetting_VerticalMarginsHeight"),
      scrollToBottom: true,
    ),
  );

  harness.addScenario(
    _highlightScenario(
      "Fade Enable Highlight",
      const Key("DisplaySettingsScreen.BooleanAppSetting_FadeEnable"),
      scrollToBottom: true,
    ),
  );

  harness.addScenario(
    _highlightScenario(
      "Fade Length Highlight",
      const Key("DisplaySettingsScreen.NumberAppSetting_FadeLength"),
      scrollToBottom: true,
    ),
  );

  harness.addScenario(
    _tapScenario(
      "Fade Length Dialog",
      const Key("DisplaySettingsScreen.NumberAppSetting_FadeLength"),
      scrollToBottom: true,
    ),
  );

  harness.addScenario(
    _highlightScenario(
      "Side Margin Highlight",
      const Key("DisplaySettingsScreen.NumberAppSetting_SideMargin"),
      scrollToBottom: true,
    ),
  );

  harness.addScenario(
    _tapScenario(
      "Side Margin Dialog",
      const Key("DisplaySettingsScreen.NumberAppSetting_SideMargin"),
      scrollToBottom: true,
    ),
  );

  harness.addScenario(
    _highlightScenario(
      "Countdown Timer Highlight",
      const Key("DisplaySettingsScreen.NumberAppSetting_CountdownTimer"),
      scrollToBottom: true,
    ),
  );

  harness.addScenario(
    _tapScenario(
      "Countdown Timer Dialog",
      const Key("DisplaySettingsScreen.NumberAppSetting_CountdownTimer"),
      scrollToBottom: true,
    ),
  );

  harness.addScenario(
    _highlightScenario(
      "Prompter Background Color Highlight",
      const Key(
        "DisplaySettingsScreen.ColorAppSetting_PrompterBackgroundColor",
      ),
      scrollToBottom: true,
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Prompter Background Color Dialog",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          featuresProvider.overrideWith(() => FeaturesFoss()),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                prompterBackgroundColor: kMarketingPrompterBackgroundColor,
              ),
            ),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await _scrollToBottom(tester);
        await tester.tap(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.ColorAppSetting_PrompterBackgroundColor",
            ),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    _highlightScenario(
      "Prompter Text Color Highlight",
      const Key("DisplaySettingsScreen.ColorAppSetting_PrompterTextColor"),
      scrollToBottom: true,
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Prompter Text Color Dialog",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          featuresProvider.overrideWith(() => FeaturesFoss()),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(prompterTextColor: kMarketingPrompterTextColor),
            ),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await _scrollToBottom(tester);
        await tester.tap(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.ColorAppSetting_PrompterTextColor",
            ),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  return harness;
}

Future<void> _scrollToBottom(WidgetTester tester) async {
  await tester.drag(find.byType(ListView), const Offset(0, -100000));
  await tester.pumpAndSettle();
}

Scenario _highlightScenario(
  String name,
  Key key, {
  bool scrollToBottom = false,
}) => Scenario(
  name: name,
  providerScopeBuilder: (child) async => ProviderScope(
    overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
    child: child,
  ),
  testCallback: (tester, binding) async {
    if (scrollToBottom) await _scrollToBottom(tester);

    await WidgetHighlighter(
      tester,
      defaultHighlightColor: kMarketingHighlightColor,
    ).highlightWidget(find.byKey(key));
  },
);

Scenario _tapScenario(String name, Key key, {bool scrollToBottom = false}) =>
    Scenario(
      name: name,
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        if (scrollToBottom) await _scrollToBottom(tester);

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();
      },
    );
