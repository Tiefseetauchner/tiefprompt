import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/core/json_converters.dart';

part 'prompter_config.freezed.dart';
part 'prompter_config.g.dart';

@freezed
abstract class PrompterConfiguration with _$PrompterConfiguration {
  const PrompterConfiguration._();

  const factory PrompterConfiguration({
    @Default(1.0) double scrollSpeed,
    @Default(false) bool mirroredX,
    @Default(false) bool mirroredY,
    @Default(42.0) double fontSize,
    @Default(0.0) double sideMargin,
    @Default('Roboto') String fontFamily,
    @TextAlignConverter() @Default(TextAlign.left) TextAlign alignment,
    @Default(false) bool displayReadingIndicatorBoxes,
    @Default(60.0) double readingIndicatorBoxesHeight,
    @Default(false) bool displayVerticalMarginBoxes,
    @Default(35.0) double verticalMarginBoxesHeight,
    @Default(false) bool verticalMarginBoxesFadeEnabled,
    @Default(50.0) double verticalMarginBoxesFadeLength,
    @Default(0.0) double countdownDuration,
    @Default(false) bool markdownEnabled,
    @Default(false) bool showControlButtons,
    @ControlButtonsPositionConverter()
    @Default(ControlButtonsPosition.left)
    ControlButtonsPosition controlButtonsPosition,
    @Default(false) bool showCurrentChapter,
  }) = _PrompterConfiguration;

  factory PrompterConfiguration.fromJson(Map<String, dynamic> json) =>
      _$PrompterConfigurationFromJson(json);

  PrompterConfiguration adjustScrollSpeed(double delta) {
    final next = scrollSpeed + delta;
    if (next < kPrompterMinSpeed || next > kPrompterMaxSpeed) return this;
    return copyWith(scrollSpeed: next);
  }

  PrompterConfiguration adjustFontSize(double delta) {
    final next = fontSize + delta;
    if (next < kPrompterMinFontSize || next > kPrompterMaxFontSize) return this;
    return copyWith(fontSize: next);
  }
}
