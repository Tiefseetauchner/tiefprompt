import 'package:flutter/material.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/disabled_feature_screen_state.dart';
import 'package:tiefprompt/providers/app_features.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_freemium.dart';

class FeaturesFakePro extends Features {
  @override
  AppFeatures build() {
    return AppFeatures(
      kAllFeatures,
      FeatureKind.paidVersion,
      "HomeScreen.PaidVersion",
    );
  }

  // No implementation for fake pro
  @override
  Future<bool> bootstrap() => Future.value(true);

  // No implementation for fake pro
  @override
  Future<bool> buyPro() => Future.value(true);

  // No implementation for fake pro
  @override
  Future<bool> restorePurchase() => Future.value(true);

  // No implementation for fake pro
  @override
  Widget getPurchaseScreen(DisabledFeatureScreenRouterExtra? extra) =>
      SizedBox.shrink();

  @override
  Widget Function(BuildContext) getFeaturePopup() =>
      (context) => ProFeatureVersionPopupContent();
}
