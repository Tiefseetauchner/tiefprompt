import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/app_features.dart';
import 'package:tiefprompt/providers/banner_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/in_app_purchase_provider.dart';

class FeaturesFreemium extends Features {
  late final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _sub;

  final Set<String> _productIds = {kProId};

  @override
  Future<bool> bootstrap() async {
    _sub ??= _iap.purchaseStream.listen(
      (details) => unawaited(_onPurchaseUpdate(details)),
      onError: (error) {
        ref.read(bannerMessageProvider.notifier).state =
            "Failed to initialize payment model: $error";
      },
    );
    ref.onDispose(() {
      _sub?.cancel();
      _sub = null;
    });

    try {
      if (!await _iap.isAvailable()) {
        ref.read(bannerMessageProvider.notifier).state =
            "Failed to initialize payment model: InAppPurchase is not available";
        return false;
      }
    } catch (e) {
      ref.read(bannerMessageProvider.notifier).state =
          "Failed to initialize payment model: $e";

      if (kDebugMode) print(e);

      return false;
    }

    final resp = await _iap.queryProductDetails(_productIds);
    if (resp.error != null) {
      ref.read(bannerMessageProvider.notifier).state =
          "Failed to initialize payment model: failed to load product details: ${resp.error}";
      return false;
    } else if (resp.notFoundIDs.isNotEmpty) {
      ref.read(bannerMessageProvider.notifier).state =
          "Failed to initialize payment model: Ids were not found. ${resp.notFoundIDs.join(", ")}";
      return false;
    } else {
      ref
          .read(inAppPurchaseDataProvider.notifier)
          .setProducts(resp.productDetails);
    }

    if (Platform.isAndroid) {
      final resp = await InAppPurchase.instance
          .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>()
          .queryPastPurchases();
      await _onPurchaseUpdate(resp.pastPurchases);
    } else {
      await _iap.restorePurchases();
    }

    return true;
  }

  Future<void> _onPurchaseUpdate(List<PurchaseDetails> details) async {
    for (final p in details) {
      switch (p.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          if (p.pendingCompletePurchase) await _iap.completePurchase(p);
          ref.read(inAppPurchaseDataProvider.notifier).addOwned(p.productID);
          state = build();
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
    if (ref.read(inAppPurchaseDataProvider).owned.contains(kProId)) {
      return AppFeatures(kAllFeatures, FeatureKind.paidVersion);
    }

    return AppFeatures(kFreeFeatures, FeatureKind.freeVersion);
  }

  @override
  Future<void> buyPro() async {
    final proProduct = ref
        .read(inAppPurchaseDataProvider)
        .products
        .where((p) => p.id == kProId)
        .singleOrNull;

    if (ref.read(inAppPurchaseDataProvider).owned.contains(kProId)) {
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
        await _onPurchaseUpdate(resp.pastPurchases);
      } else {
        await _iap.restorePurchases();
      }
      return true;
    } catch (e) {
      ref.read(bannerMessageProvider.notifier).state =
          "Failed to restore purchases: $e";

      if (kDebugMode) print(e);

      return false;
    }
  }
}
