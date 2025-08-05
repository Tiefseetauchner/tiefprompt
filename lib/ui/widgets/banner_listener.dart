import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/banner_provider.dart';

class BannerListener extends ConsumerStatefulWidget {
  final Widget child;

  const BannerListener({super.key, required this.child});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BannerListenerState();
}

class _BannerListenerState extends ConsumerState<BannerListener> {
  ProviderSubscription? _bannerListener;

  @override
  void initState() {
    _bannerListener?.close();
    _bannerListener = ref.listenManual<String?>(bannerMessageProvider, (
      previous,
      next,
    ) {
      final messenger = ScaffoldMessenger.of(context);
      if (next != null) {
        messenger.showMaterialBanner(
          MaterialBanner(
            content: Text(next),
            actions: [
              TextButton(
                onPressed: () {
                  messenger.hideCurrentMaterialBanner();
                  ref.read(bannerMessageProvider.notifier).state = null;
                },
                child: Text(context.tr("HomeScreen.Understood")),
              ),
            ],
          ),
        );
      } else {
        messenger.hideCurrentMaterialBanner();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _bannerListener?.close();
    super.dispose();
  }
}
