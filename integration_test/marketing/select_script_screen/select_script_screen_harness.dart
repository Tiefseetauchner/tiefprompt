import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_foss.dart';
import 'package:tiefprompt/ui/screens/open_file_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../harness_preparation.dart';

@RegisterHarness('MarketingTablet')
Future<ScenarioHarness> buildSelectScriptScreenHarness() async {
  final harness = prepareScreenshotHarness(
    "Select Script Screen",
    screenshotManager: ScreenshotManager(serverPort: 3824),
    appContent: OpenFileScreen(),
  );

  harness.addScenario(
    Scenario(
      name: "Foss",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
    ),
  );

  return harness;
}
