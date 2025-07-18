import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

part 'prompter_provider.freezed.dart';
part 'prompter_provider.g.dart';

@freezed
abstract class PrompterState with _$PrompterState {
  factory PrompterState({
    @Default(1.0) double speed,
    @Default(false) bool mirroredX,
    @Default(false) bool mirroredY,
    @Default(48.0) double fontSize,
    @Default(false) bool isPlaying,
    @Default(0.0) double sideMargin,
    @Default('Roboto') String fontFamily,
    @Default(TextAlign.left) TextAlign alignment,
    @Default(false) bool displayReadingIndicatorBoxes,
    @Default(25.0) double readingIndicatorBoxesHeight,
    @Default(false) bool displayVerticalMarginBoxes,
    @Default(25.0) double verticalMarginBoxesHeight,
    @Default(5.0) double countdownDuration,
    @Default(false) bool displayCountdown,
    @Default(false) bool verticalMarginBoxesFadeEnabled,
    @Default(0.0) double verticalMarginBoxesFadeLength,
  }) = _PrompterState;
}

@riverpod
class Prompter extends _$Prompter {
  Timer? _playPauseTimer;

  @override
  PrompterState build() {
    return PrompterState();
  }

  // IMPROVE: Get rid of this somehow this is just awful duplication. DRY!
  void applySettings(SettingsState settings) {
    state = state.copyWith(
      speed: settings.scrollSpeed,
      mirroredX: settings.mirroredX,
      mirroredY: settings.mirroredY,
      fontSize: settings.fontSize,
      sideMargin: settings.sideMargin,
      fontFamily: settings.fontFamily,
      alignment: settings.alignment,
      displayReadingIndicatorBoxes: settings.displayReadingIndicatorBoxes,
      readingIndicatorBoxesHeight: settings.readingIndicatorBoxesHeight,
      displayVerticalMarginBoxes: settings.displayVerticalMarginBoxes,
      verticalMarginBoxesHeight: settings.verticalMarginBoxesHeight,
      countdownDuration: settings.countdownDuration,
      verticalMarginBoxesFadeEnabled: settings.verticalMarginBoxesFadeEnabled,
      verticalMarginBoxesFadeLength: settings.verticalMarginBoxesFadeLength,
    );
  }

  void setSpeed(double speed) {
    state = state.copyWith(speed: speed);
  }

  void increaseSpeed(double amount) {
    if (state.speed + amount > kPrompterMaxSpeed) {
      return;
    }

    state = state.copyWith(speed: state.speed + amount);
  }

  void decreaseSpeed(double amount) {
    if (state.speed - amount < kPrompterMinSpeed) {
      return;
    }

    state = state.copyWith(speed: state.speed - amount);
  }

  void togglePlayPause() {
    if (state.isPlaying || _playPauseTimer != null) {
      _playPauseTimer?.cancel();
      _playPauseTimer = null;
      state = state.copyWith(displayCountdown: false, isPlaying: false);
    } else {
      state = state.copyWith(displayCountdown: true);
      _playPauseTimer?.cancel();
      _playPauseTimer = Timer(
        Duration(seconds: state.countdownDuration.toInt()),
        () {
          state = state.copyWith(isPlaying: true, displayCountdown: false);
          _playPauseTimer = null;
        },
      );
    }
  }

  void toggleMirroredX() {
    state = state.copyWith(mirroredX: !state.mirroredX);
  }

  void toggleMirroredY() {
    state = state.copyWith(mirroredY: !state.mirroredY);
  }

  void toggleDisplayReadingIndicatorBoxes() {
    state = state.copyWith(
      displayReadingIndicatorBoxes: !state.displayReadingIndicatorBoxes,
    );
  }

  void setReadingIndicatorBoxHeight(double height) {
    state = state.copyWith(readingIndicatorBoxesHeight: height);
  }

  void toggleDisplayVerticalMarginBoxes() {
    state = state.copyWith(
      displayVerticalMarginBoxes: !state.displayVerticalMarginBoxes,
    );
  }

  void setVerticalMarginBoxHeight(double height) {
    state = state.copyWith(verticalMarginBoxesHeight: height);
  }

  void setSideMargin(double sideMargin) {
    state = state.copyWith(sideMargin: sideMargin);
  }

  void increaseFontSize(double amount) {
    if (state.fontSize + amount > kPrompterMaxFontSize) {
      return;
    }

    state = state.copyWith(fontSize: state.fontSize + amount);
  }

  void decreaseFontSize(double amount) {
    if (state.fontSize - amount < kPrompterMinFontSize) {
      return;
    }

    state = state.copyWith(fontSize: state.fontSize - amount);
  }

  void setFontFamily(String fontFamily) {
    state = state.copyWith(fontFamily: fontFamily);
  }

  void setAlignment(TextAlign alignment) {
    state = state.copyWith(alignment: alignment);
  }

  void setCountdownDuration(double duration) {
    state = state.copyWith(countdownDuration: duration);
  }

  void toggleVerticalMarginBoxesFadeEnabled() {
    state = state.copyWith(
      verticalMarginBoxesFadeEnabled: !state.verticalMarginBoxesFadeEnabled,
    );
  }

  void setVerticalMarginBoxesFadeLength(double fadeLength) {
    state = state.copyWith(verticalMarginBoxesFadeLength: fadeLength);
  }
}
