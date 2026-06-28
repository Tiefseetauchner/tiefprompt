import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tief_weave/markdown.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/in_app_purchase_provider.dart';
import 'package:tiefprompt/ui/widgets/safe_scaffold.dart';

class BuyProScreen extends ConsumerWidget {
  final Feature? feature;

  const BuyProScreen({super.key, this.feature});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var proPrice = ref
        .read(inAppPurchaseDataProvider)
        .products
        .where((p) => p.id == kProId)
        .firstOrNull
        ?.price;
    return SafeScaffold(
      appBar: AppBar(title: Text(context.tr("BuyProScreen.Title"))),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: context.pop,
          child: Text(context.tr("BuyProScreen.Back")),
        ),
        ElevatedButton(
          onPressed: () =>
              ref.read(featuresProvider.notifier).restorePurchase(),
          child: Text(context.tr("BuyProScreen.RestorePurchases")),
        ),
        ElevatedButton(
          onPressed: () => ref.read(featuresProvider.notifier).buyPro(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          child: Text(
            "${context.tr("BuyProScreen.BuyPro")}${proPrice == null ? "" : " ($proPrice)"}",
          ),
        ),
      ],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Markdown(
                  textAlign: TextAlign.left,
                  context.tr(
                    "BuyProScreen.BuyRequest.${feature?.name ?? "Generic"}",
                  ),
                ),
                ElevatedButton(
                  onPressed: () => ref.read(featuresProvider.notifier).buyPro(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text(
                    "${context.tr("BuyProScreen.BuyPro")}${proPrice == null ? "" : " ($proPrice)"}",
                  ),
                ),
                Markdown(
                  textAlign: TextAlign.left,
                  context.tr("BuyProScreen.BuyRequest.MainBlock"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
