import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/models/keybinding.dart';
import 'package:tiefprompt/providers/keybinding_provider.dart';
import 'package:tiefprompt/ui/screens/settings/keybindings_settings_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('Marketing Tablet', name: "Keybindings Settings Screen")
Future<ScenarioHarness> buildKeybindingsSettingsHarness() async {
  final harness = prepareScreenshotHarness(
    appContent: const KeybindingsSettingsScreen(),
  );

  harness.addScenario(Scenario(name: "Light Theme"));

  harness.addScenario(
    Scenario(
      name: "Play Pause Highlight",
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(
              const Key(
                "KeybindingsSettingsScreen.KeybindingAppSetting_playPause",
              ),
            ),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Play Pause Dialog",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key(
              "KeybindingsSettingsScreen.KeybindingAppSetting_playPause",
            ),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Add Binding Highlight",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key(
              "KeybindingsSettingsScreen.KeybindingAppSetting_playPause",
            ),
          ),
        );
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(const Key("KeybindingAppSetting.ListTile_AddBinding")),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Add Binding Dialog",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key(
              "KeybindingsSettingsScreen.KeybindingAppSetting_playPause",
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(
          find.byKey(const Key("KeybindingAppSetting.ListTile_AddBinding")),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Custom Binding Dialog",
      testCallback: (tester, binding) async {
        final container = ProviderScope.containerOf(
          tester.element(find.byType(KeybindingsSettingsScreen)),
        );

        await container
            .read(keybindingsProvider.notifier)
            .addBinding(
              KeybindingAction.playPause,
              Keybinding(keyId: LogicalKeyboardKey.keyP.keyId, ctrl: true),
            );
        await tester.pumpAndSettle();

        await tester.tap(
          find.byKey(
            const Key(
              "KeybindingsSettingsScreen.KeybindingAppSetting_playPause",
            ),
          ),
        );
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(find.byIcon(Icons.delete).last, padding: 8);
      },
    ),
  );

  return harness;
}

@RegisterHarness('Marketing Wide Tablet', name: "Keybindings Settings Screen")
Future<ScenarioHarness> buildKeybindingsSettingsWideHarness() async {
  final harness = prepareScreenshotHarness(
    appContent: const KeybindingsSettingsScreen(),
  );

  harness.addScenario(Scenario(name: "Foss"));

  return harness;
}
