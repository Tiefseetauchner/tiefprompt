import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/settings/display_settings_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../fake_providers/features_fake_free.dart';
import '../../fake_providers/settings_fake.dart';
import '../../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('Marketing Tablet', name: "Display Settings Screen")
Future<ScenarioHarness> buildDisplaySettingsHarness() async {
  final harness = prepareScreenshotHarness(
    appContent: const DisplaySettingsScreen(),
  );

  harness.addScenario(Scenario(name: "Light Theme"));

  harness.addScenario(
    Scenario(
      name: "Flip Highlight",
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
          ], padding: 8),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Control Buttons Enable Highlight",
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.BooleanAppSetting_ControlButtonsEnable",
            ),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Control Buttons Position Highlight",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.BooleanAppSetting_ControlButtonsEnable",
            ),
          ),
        );
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.DropdownAppSetting_ControlButtonsPosition",
            ),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Control Buttons Position Open",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.BooleanAppSetting_ControlButtonsEnable",
            ),
          ),
        );
        await tester.pumpAndSettle();

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
    Scenario(
      name: "Reading Indicators Highlight",
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.BooleanAppSetting_ReadingIndicators",
            ),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Reading Indicators Height Highlight",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.BooleanAppSetting_ReadingIndicators",
            ),
          ),
        );
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.NumberAppSetting_ReadingIndicatorsHeight",
            ),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Reading Indicators Height Dialog",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.BooleanAppSetting_ReadingIndicators",
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.NumberAppSetting_ReadingIndicatorsHeight",
            ),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Vertical Margins Enable Highlight",
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.BooleanAppSetting_VerticalMarginsEnable",
            ),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Vertical Margins Height Highlight",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.BooleanAppSetting_VerticalMarginsEnable",
            ),
          ),
        );
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.NumberAppSetting_VerticalMarginsHeight",
            ),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Vertical Margins Height Dialog",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.BooleanAppSetting_VerticalMarginsEnable",
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.NumberAppSetting_VerticalMarginsHeight",
            ),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Fade Enable Highlight",
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key("DisplaySettingsScreen.BooleanAppSetting_FadeEnable"),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Fade Length Highlight",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key("DisplaySettingsScreen.BooleanAppSetting_FadeEnable"),
          ),
        );
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key("DisplaySettingsScreen.NumberAppSetting_FadeLength"),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Fade Length Dialog",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key("DisplaySettingsScreen.BooleanAppSetting_FadeEnable"),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(
          find.byKey(
            const Key("DisplaySettingsScreen.NumberAppSetting_FadeLength"),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Side Margin Highlight",
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key("DisplaySettingsScreen.NumberAppSetting_SideMargin"),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Side Margin Dialog",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key("DisplaySettingsScreen.NumberAppSetting_SideMargin"),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Prompter Background Color Highlight",
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.ColorAppSetting_PrompterBackgroundColor",
            ),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Prompter Background Color Dialog",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
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
    Scenario(
      name: "Prompter Text Color Highlight",
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.ColorAppSetting_PrompterTextColor",
            ),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Prompter Text Color Dialog",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(prompterTextColor: kMarketingPrompterTextColor),
            ),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) async {
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

  harness.addScenario(
    Scenario(
      name: "Locked Feature Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFakeFree())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key(
              "DisplaySettingsScreen.BooleanAppSetting_ReadingIndicators",
            ),
          ),
        );
      },
    ),
  );

  return harness;
}
