import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';
import 'package:tiefprompt/core/app_bootstrap.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_unverified.dart';
import 'package:tiefprompt/providers/talker_provider.dart';
import 'package:tiefprompt/teleprompter_app.dart';

// NOTE: This is the entry point for building without a flavor selected.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await el.EasyLocalization.ensureInitialized();

  final talker = await createTalker();
  registerCrashHandlers(talker);
  talker.info('App starting (unverified flavor)');

  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver(talker: talker)],
      overrides: [
        featuresProvider.overrideWith(() => FeaturesUnverified()),
        talkerProvider.overrideWithValue(talker),
      ],
      child: el.EasyLocalization(
        supportedLocales: kSupportedLocales.map((l10n) => l10n.$2).toList(),
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        useFallbackTranslations: true,
        child: TeleprompterApp(),
      ),
    ),
  );
}
