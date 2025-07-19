import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/services/script_service.dart';

class MockApp extends StatelessWidget {
  final Widget child;
  final IScriptService? scriptServiceOverride;
  final Locale locale;

  const MockApp({
    super.key,
    required this.child,
    required this.locale,
    this.scriptServiceOverride,
  });

  @override
  Widget build(BuildContext context) {
    final supportedLocales = kSupportedLocales.map((l10n) => l10n.$2).toList();

    return ProviderScope(
      overrides: [
        scriptProvider.overrideWith(
          () => scriptServiceOverride ?? ScriptService(),
        ),
      ],
      child: EasyLocalization(
        saveLocale: false,
        supportedLocales: supportedLocales,
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        startLocale: locale,
        child: Builder(
          builder: (context) => MaterialApp(
            debugShowCheckedModeBanner: false,
            supportedLocales: supportedLocales,
            locale: locale,
            localizationsDelegates: context.localizationDelegates,
            home: child,
          ),
        ),
      ),
    );
  }
}
