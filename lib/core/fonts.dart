import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fonts.freezed.dart';

@freezed
abstract class TiefPromptFontsVariant with _$TiefPromptFontsVariant {
  factory TiefPromptFontsVariant({
    required int weight,
    required FontStyle fontStyle,
    required Future<ByteData> Function() load,
    String? originalFileName,
    @Default(false) bool isVariable,
    @Default(null) (int, int)? weightRange,
  }) = _TiefPromptFontsVariant;
}

@freezed
abstract class TiefPromptFontsFile with _$TiefPromptFontsFile {
  factory TiefPromptFontsFile({
    required String name,
    required List<TiefPromptFontsVariant> variants,
    @Default(false) bool isBuiltIn,
  }) = _TiefPromptFontsFile;
}

Future<void> registerFont(TiefPromptFontsFile file) async {
  for (final variant in file.variants) {
    final fontLoader = FontLoader(file.name);
    fontLoader.addFont(variant.load());
    await fontLoader.load();
  }
}

FontWeight nearestFontWeight(int weight) {
  final snapped = ((weight / 100).round() * 100).clamp(100, 900);
  return FontWeight.values[(snapped ~/ 100) - 1];
}
