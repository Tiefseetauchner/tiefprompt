import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tiefprompt/core/control_buttons.dart';

class EnumByNameConverter<T extends Enum> implements JsonConverter<T, String> {
  final List<T> values;
  final T fallback;

  const EnumByNameConverter(this.values, this.fallback);

  @override
  T fromJson(String json) =>
      values.firstWhere((e) => e.name == json, orElse: () => fallback);

  @override
  String toJson(T object) => object.name;
}

class TextAlignConverter extends EnumByNameConverter<TextAlign> {
  const TextAlignConverter() : super(TextAlign.values, TextAlign.left);
}

class ControlButtonsPositionConverter
    extends EnumByNameConverter<ControlButtonsPosition> {
  const ControlButtonsPositionConverter()
    : super(ControlButtonsPosition.values, ControlButtonsPosition.left);
}

class ThemeModeConverter extends EnumByNameConverter<ThemeMode> {
  const ThemeModeConverter() : super(ThemeMode.values, ThemeMode.system);
}

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color object) => object.toARGB32();
}
