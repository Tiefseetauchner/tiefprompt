import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/providers/prompter_config.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/prompter_screen.dart';
import 'package:tiefprompt/ui/widgets/prompter_bottom_bar.dart';
import 'package:tiefprompt/ui/widgets/prompter_theme_scope.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../fake_providers/script_fake.dart';
import '../../fake_providers/settings_fake.dart';
import '../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('Marketing Wide Tablet', name: "Prompter Screen")
Future<ScenarioHarness> buildPrompterScreenHarness() async {
  final harness = prepareScreenshotHarness(
    screenshotManager: ScreenshotManager(serverPort: 3824),
    appContent: PrompterThemeScope(child: PrompterScreen()),
  );

  harness.addScenario(
    Scenario(
      name: "Configured Script",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
              scrollPosition: 1800,
            ),
          ),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(
                  alignment: TextAlign.center,
                  fontFamily: "RobotoSlab",
                  fontSize: 34,
                  sideMargin: 20,
                  displayVerticalMarginBoxes: true,
                  verticalMarginBoxesHeight: 30,
                  verticalMarginBoxesFadeEnabled: true,
                  verticalMarginBoxesFadeLength: 20,
                  displayReadingIndicatorBoxes: true,
                  readingIndicatorBoxesHeight: 80,
                  showControlButtons: true,
                  controlButtonsPosition: ControlButtonsPosition.left,
                  markdownEnabled: true,
                  showCurrentChapter: true,
                ),
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
      name: "Markdown And Chapter",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
              scrollPosition: 1800,
            ),
          ),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(
                  markdownEnabled: true,
                  showCurrentChapter: true,
                ),
              ),
            ),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await tester.tap(find.byType(GestureDetector).first);
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Custom Background Color",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
              scrollPosition: 1800,
            ),
          ),
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
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Custom Text Color",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
              scrollPosition: 1800,
            ),
          ),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(prompterTextColor: kMarketingPrompterTextColor),
            ),
          ),
        ],
        child: child,
      ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Overlays",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
              scrollPosition: 1800,
            ),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) async {
        final container = ProviderScope.containerOf(
          tester.element(find.byType(PrompterScreen)),
        );

        container.read(fontSettingsVisibleProvider.notifier).toggle();
        container.read(displaySettingsVisibleProvider.notifier).toggle();
        await tester.pumpAndSettle();
      },
    ),
  );

  return harness;
}

@RegisterHarness('Marketing Tablet', name: "Prompter Screen Narrow")
Future<ScenarioHarness> buildPrompterScreenNarrowHarness() async {
  final harness = prepareScreenshotHarness(
    screenshotManager: ScreenshotManager(serverPort: 3824),
    appContent: PrompterThemeScope(child: PrompterScreen()),
  );

  harness.addScenario(
    Scenario(
      name: "Defaults",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
              scrollPosition: 1800,
            ),
          ),
        ],
        child: child,
      ),
    ),
  );

  return harness;
}
