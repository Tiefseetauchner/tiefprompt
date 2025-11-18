import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'in_app_purchase_provider.freezed.dart';
part 'in_app_purchase_provider.g.dart';

@freezed
abstract class InAppPurchaseDataState with _$InAppPurchaseDataState {
  factory InAppPurchaseDataState({
    required List<ProductDetails> products,
    required Set<String> owned,
  }) = _InAppPurchaseDataState;
}

@Riverpod(keepAlive: true)
class InAppPurchaseData extends _$InAppPurchaseData {
  @override
  InAppPurchaseDataState build() {
    return InAppPurchaseDataState(products: const [], owned: <String>{});
  }

  void setProducts(List<ProductDetails> products) {
    state = state.copyWith(products: products);
  }

  void addOwned(String owned) {
    state = state.copyWith(owned: {...state.owned, owned});
  }

  void removeOwned(String owned) {
    final updatedOwned = {...state.owned}..remove(owned);
    state = state.copyWith(owned: updatedOwned);
  }
}
