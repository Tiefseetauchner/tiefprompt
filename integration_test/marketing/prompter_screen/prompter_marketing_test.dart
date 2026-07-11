import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_foss.dart';
import 'package:tiefprompt/providers/prompter_config.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/prompter_screen.dart';
import 'package:tiefprompt/ui/widgets/prompter_theme_scope.dart';

import '../../fake_providers/script_fake.dart';
import '../../fake_providers/settings_fake.dart';
import '../../mock_database_managers.dart';
import '../constants.dart';
import '../../scenarios/scenario.dart';

Future<void> main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final ref = ProviderContainer();
  AppDatabase db = await createSeededDatabase();

  setUpAll(() async {
    await EasyLocalization.ensureInitialized();
  });

  runScenario(
    "Prompter Screen Foss Prefilled",
    binding: binding,
    ref: ref,
    screenName: "prompter_screen_light",
    caseName: "foss_prefilled",
    appContent: PrompterThemeScope(child: PrompterScreen()),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        scriptProvider.overrideWith(
          () => ScriptFake(
            name: kMarketingScriptName,
            content: kMarketingScriptContent,
            scrollPosition: 4000,
          ),
        ),
        featuresProvider.overrideWith(() => FeaturesFoss()),
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
        settingsProvider.overrideWith(
          () => SettingsFake(
            SettingsState(
              config: PrompterConfiguration(
                alignment: TextAlign.center,
                fontFamily: "RobotoSlab",
                fontSize: 60,
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
  );

  tearDownAll(() async {
    await uploadScreenshots(ref);
  });
}
