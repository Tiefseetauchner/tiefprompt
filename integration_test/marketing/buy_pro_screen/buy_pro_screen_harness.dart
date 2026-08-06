import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tief_test_harness/tief_test_harness.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/ui/screens/buy_pro_screen.dart';

import '../../fake_providers/features_fake_free.dart';
import '../harness_preparation.dart';

@RegisterHarness('Marketing Tablet Freemium', name: "Buy Pro Screen")
Future<ScenarioHarness> buildBuyProScreenHarness() async {
  final harness = prepareScreenshotHarness();

  harness.addScenario(
    Scenario(
      name: "Reading Indicator Boxes",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFakeFree())],
        child: child,
      ),
      overrideAppContent: const BuyProScreen(
        feature: Feature.readingIndicatorBoxes,
      ),
    ),
  );

  return harness;
}
