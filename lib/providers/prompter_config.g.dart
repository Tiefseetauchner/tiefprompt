// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompter_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrompterConfiguration _$PrompterConfigurationFromJson(
  Map<String, dynamic> json,
) => _PrompterConfiguration(
  scrollSpeed: (json['scrollSpeed'] as num?)?.toDouble() ?? 1.0,
  mirroredX: json['mirroredX'] as bool? ?? false,
  mirroredY: json['mirroredY'] as bool? ?? false,
  fontSize: (json['fontSize'] as num?)?.toDouble() ?? 42.0,
  sideMargin: (json['sideMargin'] as num?)?.toDouble() ?? 0.0,
  fontFamily: json['fontFamily'] as String? ?? 'Roboto',
  alignment: json['alignment'] == null
      ? TextAlign.left
      : const TextAlignConverter().fromJson(json['alignment'] as String),
  displayReadingIndicatorBoxes:
      json['displayReadingIndicatorBoxes'] as bool? ?? false,
  readingIndicatorBoxesHeight:
      (json['readingIndicatorBoxesHeight'] as num?)?.toDouble() ?? 60.0,
  displayVerticalMarginBoxes:
      json['displayVerticalMarginBoxes'] as bool? ?? false,
  verticalMarginBoxesHeight:
      (json['verticalMarginBoxesHeight'] as num?)?.toDouble() ?? 35.0,
  verticalMarginBoxesFadeEnabled:
      json['verticalMarginBoxesFadeEnabled'] as bool? ?? false,
  verticalMarginBoxesFadeLength:
      (json['verticalMarginBoxesFadeLength'] as num?)?.toDouble() ?? 50.0,
  countdownDuration: (json['countdownDuration'] as num?)?.toDouble() ?? 0.0,
  markdownEnabled: json['markdownEnabled'] as bool? ?? false,
  showControlButtons: json['showControlButtons'] as bool? ?? false,
  controlButtonsPosition: json['controlButtonsPosition'] == null
      ? ControlButtonsPosition.left
      : const ControlButtonsPositionConverter().fromJson(
          json['controlButtonsPosition'] as String,
        ),
  showCurrentChapter: json['showCurrentChapter'] as bool? ?? false,
  textDirectionMode:
      $enumDecodeNullable(
        _$TextDirectionModeEnumMap,
        json['textDirectionMode'],
      ) ??
      TextDirectionMode.auto,
);

Map<String, dynamic> _$PrompterConfigurationToJson(
  _PrompterConfiguration instance,
) => <String, dynamic>{
  'scrollSpeed': instance.scrollSpeed,
  'mirroredX': instance.mirroredX,
  'mirroredY': instance.mirroredY,
  'fontSize': instance.fontSize,
  'sideMargin': instance.sideMargin,
  'fontFamily': instance.fontFamily,
  'alignment': const TextAlignConverter().toJson(instance.alignment),
  'displayReadingIndicatorBoxes': instance.displayReadingIndicatorBoxes,
  'readingIndicatorBoxesHeight': instance.readingIndicatorBoxesHeight,
  'displayVerticalMarginBoxes': instance.displayVerticalMarginBoxes,
  'verticalMarginBoxesHeight': instance.verticalMarginBoxesHeight,
  'verticalMarginBoxesFadeEnabled': instance.verticalMarginBoxesFadeEnabled,
  'verticalMarginBoxesFadeLength': instance.verticalMarginBoxesFadeLength,
  'countdownDuration': instance.countdownDuration,
  'markdownEnabled': instance.markdownEnabled,
  'showControlButtons': instance.showControlButtons,
  'controlButtonsPosition': const ControlButtonsPositionConverter().toJson(
    instance.controlButtonsPosition,
  ),
  'showCurrentChapter': instance.showCurrentChapter,
  'textDirectionMode': _$TextDirectionModeEnumMap[instance.textDirectionMode]!,
};

const _$TextDirectionModeEnumMap = {
  TextDirectionMode.ltr: 'ltr',
  TextDirectionMode.rtl: 'rtl',
  TextDirectionMode.auto: 'auto',
};
