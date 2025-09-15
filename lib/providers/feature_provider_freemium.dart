import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/app_features.dart';
import 'package:tiefprompt/providers/banner_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';

class FeaturesFreemium extends Features {
  late final InAppPurchase _iap;
  late final StreamSubscription<List<PurchaseDetails>> _sub;

  final Set<String> _productIds = {kProId};
  final Map<String, ProductDetails> _products = {};
  final Set<String> _owned = {};

  @override
  Future<bool> bootstrap() async {
    _iap = InAppPurchase.instance;

    try {
      if (!await _iap.isAvailable()) {
        ref.read(bannerMessageProvider.notifier).state =
            "Failed to initialize payment model: InAppPurchase is not available";
        return false;
      }
    } catch (e) {
      ref.read(bannerMessageProvider.notifier).state =
          "Failed to initialize payment model: $e";

      return false;
    }

    _sub = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () => _sub.cancel(),
      onError: (error) {
        ref.read(bannerMessageProvider.notifier).state =
            "Failed to initialize payment model: $error";
      },
    );

    final resp = await _iap.queryProductDetails(_productIds);
    if (resp.error != null) {
      ref.read(bannerMessageProvider.notifier).state =
          "Failed to initialize payment model: ${resp.error}";
      return false;
    } else if (resp.notFoundIDs.isNotEmpty) {
      ref.read(bannerMessageProvider.notifier).state =
          "Failed to initialize payment model: Ids were not found. ${resp.notFoundIDs.join(", ")}";
      return false;
    } else {
      _products.addEntries(resp.productDetails.map((p) => MapEntry(p.id, p)));
    }

    if (Platform.isAndroid) {
      final resp = await InAppPurchase.instance
          .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>()
          .queryPastPurchases();
      _onPurchaseUpdate(resp.pastPurchases);
    } else {
      await _iap.restorePurchases();
    }
    return true;
  }

  void _onPurchaseUpdate(List<PurchaseDetails> details) {
    for (final p in details) {
      switch (p.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _owned.add(p.productID);
          state = build();
          if (p.pendingCompletePurchase) _iap.completePurchase(p);
          break;
        case PurchaseStatus.error:
          ref.read(bannerMessageProvider.notifier).state =
              "Failed to initialize payment model: ${p.error}";
          break;
        case PurchaseStatus.canceled:
        case PurchaseStatus.pending:
          break;
      }
    }
  }

  @override
  AppFeatures build() {
    if (_owned.contains(kProId)) {
      return AppFeatures(kAllFeatures, FeatureKind.paidVersion);
    }

    return AppFeatures(kFreeFeatures, FeatureKind.freeVersion);
  }

  @override
  Future<void> buyPro() async {
    final proProduct = _products[kProId];

    if (_owned.contains(kProId)) {
      ref.read(bannerMessageProvider.notifier).state =
          "Failed to initialize purchase: $kProId is already owned by this account";
      return;
    }

    if (proProduct != null) {
      if (!await _iap.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: proProduct),
      )) {
        ref.read(bannerMessageProvider.notifier).state =
            "Failed to complete purchase.";
      }
    } else {
      ref.read(bannerMessageProvider.notifier).state =
          "Failed to initialize purchase: $kProId could not be found";
    }

    return Future.value();
  }

  @override
  Future<bool> restorePurchase() async {
    try {
      if (Platform.isAndroid) {
        final resp = await InAppPurchase.instance
            .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>()
            .queryPastPurchases();
        _onPurchaseUpdate(resp.pastPurchases);
      } else {
        await _iap.restorePurchases();
      }
      return true;
    } catch (e) {
      ref.read(bannerMessageProvider.notifier).state =
          "Failed to restore purchases: $e";
      return false;
    }
  }
}
