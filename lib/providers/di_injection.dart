import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/services/script_service.dart';
import 'package:tiefprompt/services/settings_service.dart';

part 'di_injection.g.dart';

@Riverpod(dependencies: [])
IScriptService scriptService(Ref ref) => throw UnimplementedError();

@Riverpod(dependencies: [])
ISettingsService settingsService(Ref ref) => throw UnimplementedError();
