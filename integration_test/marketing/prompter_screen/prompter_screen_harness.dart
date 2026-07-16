import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/providers/prompter_config.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/prompter_screen.dart';
import 'package:tiefprompt/ui/widgets/prompter_bottom_bar.dart';
import 'package:tiefprompt/ui/widgets/prompter_theme_scope.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../fake_providers/script_fake.dart';
import '../../fake_providers/settings_fake.dart';
import '../../constants.dart';
import '../../mock_app.dart';
import '../harness_preparation.dart';

ScriptFake _configuredScript() => ScriptFake(
  name: kMarketingScriptName,
  content: kMarketingScriptContent,
  scrollPosition: 1800,
);

SettingsFake _configuredScriptSettings({
  String fontFamily = "RobotoSlab",
  bool mirroredX = false,
}) => SettingsFake(
  SettingsState(
    config: PrompterConfiguration(
      alignment: TextAlign.center,
      fontFamily: fontFamily,
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
      mirroredX: mirroredX,
    ),
  ),
);

@RegisterHarness('Marketing Wide Tablet', name: "Prompter Screen")
Future<ScenarioHarness> buildPrompterScreenHarness() async {
  final harness = prepareLandscapeScreenshotHarness(
    appContent: const PrompterThemeScope(child: PrompterScreen()),
  );

  harness.addScenario(
    Scenario(
      name: "Configured Script",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(_configuredScript),
          settingsProvider.overrideWith(_configuredScriptSettings),
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
          scriptProvider.overrideWith(_configuredScript),
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
      name: "Configured Script No Chrome",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(_configuredScript),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(
                  alignment: TextAlign.center,
                  fontSize: 36,
                  markdownEnabled: true,
                  sideMargin: 30,
                  readingIndicatorBoxesHeight: 60,
                  displayReadingIndicatorBoxes: true,
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
      name: "Configured Script Format Overlay",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(_configuredScript),
          settingsProvider.overrideWith(_configuredScriptSettings),
        ],
        child: child,
      ),
      testCallback: (tester, binding) async {
        final container = ProviderScope.containerOf(
          tester.element(find.byType(PrompterScreen)),
        );

        container.read(fontSettingsVisibleProvider.notifier).toggle();
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Custom Background Color",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(_configuredScript),
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
          scriptProvider.overrideWith(_configuredScript),
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
      name: "Roboto Font",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
              scrollPosition: 600,
            ),
          ),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(fontFamily: "Roboto"),
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
      name: "RobotoSlab Font",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
              scrollPosition: 600,
            ),
          ),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(fontFamily: "RobotoSlab"),
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
      name: "Open Dyslexic Font",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
              scrollPosition: 600,
            ),
          ),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(fontFamily: "OpenDyslexic"),
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
      name: "Overlays",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [scriptProvider.overrideWith(_configuredScript)],
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

  harness.addScenario(
    Scenario(
      name: "Mirrored No Chrome",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(_configuredScript),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(config: PrompterConfiguration(mirroredX: true)),
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
      name: "Reading Indicators No Chrome",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(_configuredScript),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(
                  displayReadingIndicatorBoxes: true,
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
      name: "Margins No Chrome",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(_configuredScript),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(
                  sideMargin: 40,
                  displayVerticalMarginBoxes: true,
                  verticalMarginBoxesHeight: 60,
                  verticalMarginBoxesFadeEnabled: true,
                  verticalMarginBoxesFadeLength: 80,
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
      name: "Custom Colors No Chrome",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(_configuredScript),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                prompterBackgroundColor: Colors.white,
                prompterTextColor: Colors.lightGreen,
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
      name: "Crazy Typography Roboto",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(_configuredScript),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(
                  fontFamily: "Roboto",
                  fontSize: 69,
                  sideMargin: 10,
                  alignment: TextAlign.justify,
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
      name: "Crazy Typography Open Dyslexic",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(_configuredScript),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(
                  fontFamily: "OpenDyslexic",
                  fontSize: 42,
                  sideMargin: 10,
                  alignment: TextAlign.center,
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
      name: "Crazy Typography RobotoMono",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(_configuredScript),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(
                  fontFamily: "RobotoMono",
                  fontSize: 32,
                  sideMargin: 10,
                  alignment: TextAlign.right,
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
      name: "Markdown No Chrome",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(
            () => ScriptFake(
              name: kMarketingScriptName,
              content: kMarketingScriptContent,
              scrollPosition: 1400,
            ),
          ),
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
      testCallback: (tester, binding) async {
        await tester.tap(find.byType(GestureDetector).first);
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Countdown Timer No Chrome",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          scriptProvider.overrideWith(_configuredScript),
          settingsProvider.overrideWith(
            () => SettingsFake(
              SettingsState(
                config: PrompterConfiguration(countdownDuration: 10),
              ),
            ),
          ),
        ],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await tester.tap(find.byType(GestureDetector).first);
        await tester.pumpAndSettle();

        final container = ProviderScope.containerOf(
          tester.element(find.byType(PrompterScreen)),
        );

        container.read(prompterProvider.notifier).displayCountdown();

        // Wait for countdown timer to reach five seconds
        await tester.pumpFrames(
          tester.widget(find.byType(MockApp)),
          const Duration(seconds: 4),
        );
      },
    ),
  );

  return harness;
}

@RegisterHarness('Marketing Tablet', name: "Prompter Screen Narrow")
Future<ScenarioHarness> buildPrompterScreenNarrowHarness() async {
  final harness = prepareScreenshotHarness(
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
