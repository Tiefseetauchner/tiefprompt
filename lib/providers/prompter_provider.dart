import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/providers/prompter_config.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

part 'prompter_provider.freezed.dart';
part 'prompter_provider.g.dart';

@freezed
abstract class PrompterState with _$PrompterState {
  factory PrompterState({
    @Default(false) bool isPlaying,
    @Default(false) bool displayCountdown,
    @Default(PrompterConfiguration()) PrompterConfiguration config,
  }) = _PrompterState;
}

@riverpod
class Prompter extends _$Prompter {
  Timer? _playPauseTimer;

  @override
  PrompterState build() {
    return PrompterState();
  }

  void applySettings(SettingsState settings) {
    state = state.copyWith(config: settings.config);
  }

  void _mutateConfig(
    PrompterConfiguration Function(PrompterConfiguration config) update,
  ) {
    state = state.copyWith(config: update(state.config));
  }

  void setSpeed(double speed) {
    _mutateConfig((config) => config.copyWith(scrollSpeed: speed));
  }

  void increaseSpeed(double amount) =>
      _mutateConfig((config) => config.adjustScrollSpeed(amount));

  void decreaseSpeed(double amount) =>
      _mutateConfig((config) => config.adjustScrollSpeed(-amount));

  void togglePlayPause() {
    if (state.isPlaying || _playPauseTimer != null) {
      _playPauseTimer?.cancel();
      _playPauseTimer = null;
      state = state.copyWith(displayCountdown: false, isPlaying: false);
    } else {
      state = state.copyWith(displayCountdown: true);
      _playPauseTimer?.cancel();
      _playPauseTimer = Timer(
        Duration(seconds: state.config.countdownDuration.toInt()),
        () {
          state = state.copyWith(isPlaying: true, displayCountdown: false);
          _playPauseTimer = null;
        },
      );
    }
  }

  void toggleMirroredX() {
    _mutateConfig((config) => config.copyWith(mirroredX: !config.mirroredX));
  }

  void toggleMirroredY() {
    _mutateConfig((config) => config.copyWith(mirroredY: !config.mirroredY));
  }

  void toggleDisplayReadingIndicatorBoxes() {
    _mutateConfig(
      (config) => config.copyWith(
        displayReadingIndicatorBoxes: !config.displayReadingIndicatorBoxes,
      ),
    );
  }

  void setReadingIndicatorBoxHeight(double height) {
    _mutateConfig(
      (config) => config.copyWith(readingIndicatorBoxesHeight: height),
    );
  }

  void toggleDisplayVerticalMarginBoxes() {
    _mutateConfig(
      (config) => config.copyWith(
        displayVerticalMarginBoxes: !config.displayVerticalMarginBoxes,
      ),
    );
  }

  void setVerticalMarginBoxHeight(double height) {
    _mutateConfig(
      (config) => config.copyWith(verticalMarginBoxesHeight: height),
    );
  }

  void setSideMargin(double sideMargin) {
    _mutateConfig((config) => config.copyWith(sideMargin: sideMargin));
  }

  void increaseFontSize(double amount) =>
      _mutateConfig((config) => config.adjustFontSize(amount));

  void decreaseFontSize(double amount) =>
      _mutateConfig((config) => config.adjustFontSize(-amount));

  void setFontFamily(String fontFamily) {
    _mutateConfig((config) => config.copyWith(fontFamily: fontFamily));
  }

  void setAlignment(TextAlign alignment) {
    _mutateConfig((config) => config.copyWith(alignment: alignment));
  }

  void setCountdownDuration(double duration) {
    _mutateConfig((config) => config.copyWith(countdownDuration: duration));
  }

  void toggleVerticalMarginBoxesFadeEnabled() {
    _mutateConfig(
      (config) => config.copyWith(
        verticalMarginBoxesFadeEnabled: !config.verticalMarginBoxesFadeEnabled,
      ),
    );
  }

  void setVerticalMarginBoxesFadeLength(double fadeLength) {
    _mutateConfig(
      (config) => config.copyWith(verticalMarginBoxesFadeLength: fadeLength),
    );
  }

  void toggleMarkdownEnabled() {
    _mutateConfig(
      (config) => config.copyWith(markdownEnabled: !config.markdownEnabled),
    );
  }

  void toggleShowControlButtons() {
    _mutateConfig(
      (config) =>
          config.copyWith(showControlButtons: !config.showControlButtons),
    );
  }

  void setControlButtonsPosition(ControlButtonsPosition position) {
    _mutateConfig(
      (config) => config.copyWith(controlButtonsPosition: position),
    );
  }

  void toggleCurrentChapterEnabled() {
    _mutateConfig(
      (config) =>
          config.copyWith(showCurrentChapter: !config.showCurrentChapter),
    );
  }
}
