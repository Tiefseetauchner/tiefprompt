import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';
import 'package:tiefprompt/providers/voice_activation_provider.dart';
import 'package:tiefprompt/ui/screens/settings/scroll_settings_screen.dart';

import '../../constants.dart';
import '../../fake_providers/voice_activation_fake.dart';
import '../harness_preparation.dart';

@RegisterHarness('Marketing Tablet', name: "Scroll Settings Screen")
Future<ScenarioHarness> buildScrollSettingsHarness() async {
  final harness = prepareScreenshotHarness(
    appContent: const ScrollSettingsScreen(),
  );

  harness.addScenario(
    Scenario(
      name: "Light Theme",
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Scroll Speed Highlight",
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(const Key("SettingsScreen.ScrollSettings.DefaultScrollSpeed")),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Scroll Speed Dialog",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.DefaultScrollSpeed")),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Countdown Timer Highlight",
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(const Key("SettingsScreen.ScrollSettings.CountdownTimer")),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Countdown Timer Dialog",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.CountdownTimer")),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Voice Activation Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          voiceActivationProvider.overrideWith(() => VoiceActivationFake()),
        ],
        child: child),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivation"))
        );
        await tester.pumpAndSettle();
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivation")),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Voice Activation Sensitivity Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          voiceActivationProvider.overrideWith(() => VoiceActivationFake()),
        ],
        child: child),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivation"))
        );
        await tester.pumpAndSettle();
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivationThreshold")),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Voice Activation Sensitivity Dialog",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          voiceActivationProvider.overrideWith(() => VoiceActivationFake()),
        ],
        child: child),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivation"))
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivationThreshold")),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Audio Device Dropdown Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          voiceActivationProvider.overrideWith(() => VoiceActivationFake()),
        ],
        child: child),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivation"))
        );
        await tester.pumpAndSettle();
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivationDevices")),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Audio Device Dropdown Dialog",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          voiceActivationProvider.overrideWith(() => VoiceActivationFake()),
        ],
        child: child),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivation"))
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.descendant(
            of: find.byKey(
              const Key("SettingsScreen.ScrollSettings.VoiceActivationDevices"),
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
      name: "Preview Voice Activation Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          voiceActivationProvider.overrideWith(() => VoiceActivationFake()),
        ],
        child: child),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivation"))
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivationPreview")),
        );
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivationPreview")),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Preview Voice Activation Active",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [
          voiceActivationProvider.overrideWith(() => VoiceActivationFake()),
        ],
        child: child),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.VoiceActivation"))
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  return harness;
}
