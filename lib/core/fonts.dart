import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talker/talker.dart';

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

List<TiefPromptFontsVariant> getSortedVariants(
  List<TiefPromptFontsVariant> variants,
) {
  final sorted = [...variants];
  sorted.sort((a, b) {
    if (a.weight != b.weight) {
      return a.weight.compareTo(b.weight);
    }
    return a.fontStyle.index.compareTo(b.fontStyle.index);
  });
  return sorted;
}

Future<void> registerFont(TiefPromptFontsFile file, Talker talker) async {
  String variantLogs = '';

  for (final variant in file.variants) {
    variantLogs += "${_logVariantDetails(file.name, variant)}\n";

    final fontLoader = FontLoader(file.name);
    fontLoader.addFont(variant.load());
    await fontLoader.load();
  }

  talker.debug(variantLogs);
}

String _logVariantDetails(String fileName, TiefPromptFontsVariant variant) {
  return "  Registering variant for font family $fileName:\n"
      "    Weight: ${variant.weight}, Style: ${variant.fontStyle}\n"
      "    Original File Name: ${variant.originalFileName}\n"
      "    Is Variable: ${variant.isVariable}\n"
      "    Weight Range: ${variant.weightRange}.";
}
