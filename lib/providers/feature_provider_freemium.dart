import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/app_features.dart';
import 'package:tiefprompt/providers/feature_provider.dart';

class FeaturesFreemium extends Features {
  late final _iap;
  late final StreamSubscription<List<PurchaseDetails>> _sub;

  final Set<String> _productIds = {kProId};
  final Map<String, ProductDetails> _products = {};
  final Set<String> _owned = {};
  String? _initError;

  @override
  Future<void> bootstrap() async {
    _iap = InAppPurchase.instance;
    _sub = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () => _sub.cancel(),
      onError: (error) {
        _initError = error.toString();
      },
    );

    final resp = await _iap.queryProductDetails(_productIds);
    if (resp.error != null) {
      _initError = resp.error!.message;
    } else {
      _products.addEntries(resp.productDetails.map((p) => MapEntry(p.id, p)));
    }

    await _iap.restorePurchases();
  }

  void _onPurchaseUpdate(List<PurchaseDetails> details) {
    for (final p in details) {
      switch (p.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _owned.add(p.productID);
          if (p.pendingCompletePurchase) _iap.completePurchase(p);
          break;
        case PurchaseStatus.error:
          // ignore: unnecessary_null_comparison - state can be null during initialization
          if (state != null) {
            state = state.copyWith(featureError: 'purchase error: ${p.error}');
          } else {
            _initError = 'purchase error: ${p.error}';
          }
          break;
        case PurchaseStatus.canceled:
        case PurchaseStatus.pending:
          break;
      }
    }
  }

  @override
  AppFeatures build() {
    if (_initError != null) {
      return AppFeatures(
        kFreeFeatures,
        FeatureKind.unverifiedBuild,
        _initError,
      );
    }

    if (_owned.contains(kProId)) {
      return AppFeatures(kAllFeatures, FeatureKind.paidVersion, null);
    }

    return AppFeatures(kFreeFeatures, FeatureKind.freeVersion, _initError);
  }
}
