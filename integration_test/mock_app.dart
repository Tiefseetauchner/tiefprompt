import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/di_injection.dart';
import 'package:tiefprompt/services/script_service.dart';

class MockApp extends StatelessWidget {
  final Widget child;
  final IScriptService? scriptServiceOverride;

  const MockApp({super.key, required this.child, this.scriptServiceOverride});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        scriptServiceProvider
            .overrideWithValue(scriptServiceOverride ?? ScriptService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: child,
      ),
    );
  }
}
