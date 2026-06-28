import 'package:flutter/widgets.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/disabled_feature_screen_state.dart';
import 'package:tiefprompt/providers/app_features.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/ui/screens/no_purchase_available_screen.dart';

class FeaturesUnverified extends Features {
  @override
  AppFeatures build() {
    return AppFeatures(kAllFeatures, FeatureKind.unverifiedBuild);
  }

  @override
  Future<bool> bootstrap() {
    // No bootstrap logic for unverified builds
    return Future.value(true);
  }

  @override
  Future<void> buyPro() {
    // No purchase logic for unverified builds
    return Future.value();
  }

  @override
  Future<bool> restorePurchase() {
    // No restore logic for unverified builds
    return Future.value(false);
  }

  @override
  Widget getPurchaseScreen(DisabledFeatureScreenRouterExtra? extra) {
    // No purchases available for unverified builds
    return NoPurchaseAvailableScreen();
  }
}
