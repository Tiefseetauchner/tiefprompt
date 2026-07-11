import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_foss.dart';
import 'package:tiefprompt/providers/prompter_config.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/prompter_screen.dart';
import 'package:tiefprompt/ui/widgets/prompter_theme_scope.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../fake_providers/script_fake.dart';
import '../../fake_providers/settings_fake.dart';
import '../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('MarketingWideTablet')
Future<ScenarioHarness> buildPrompterScreenHarness() async {
  final harness = prepareScreenshotHarness(
    "Prompter Screen",
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
          featuresProvider.overrideWith(() => FeaturesFoss()),
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

  return harness;
}
