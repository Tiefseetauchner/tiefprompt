// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keybinding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Keybinding _$KeybindingFromJson(Map<String, dynamic> json) => _Keybinding(
  keyId: (json['keyId'] as num).toInt(),
  ctrl: json['ctrl'] as bool? ?? false,
  shift: json['shift'] as bool? ?? false,
  alt: json['alt'] as bool? ?? false,
  meta: json['meta'] as bool? ?? false,
);

Map<String, dynamic> _$KeybindingToJson(_Keybinding instance) =>
    <String, dynamic>{
      'keyId': instance.keyId,
      'ctrl': instance.ctrl,
      'shift': instance.shift,
      'alt': instance.alt,
      'meta': instance.meta,
    };

_KeybindingMap _$KeybindingMapFromJson(Map<String, dynamic> json) =>
    _KeybindingMap(
      keybindings: (json['keybindings'] as List<dynamic>)
          .map(
            (e) => _$recordConvert(
              e,
              ($jsonValue) => (
                $enumDecode(_$CommandActionEnumMap, $jsonValue[r'$1']),
                Keybinding.fromJson($jsonValue[r'$2'] as Map<String, dynamic>),
              ),
            ),
          )
          .toList(),
    );

Map<String, dynamic> _$KeybindingMapToJson(_KeybindingMap instance) =>
    <String, dynamic>{
      'keybindings': instance.keybindings
          .map(
            (e) => <String, dynamic>{
              r'$1': _$CommandActionEnumMap[e.$1]!,
              r'$2': e.$2,
            },
          )
          .toList(),
    };

const _$CommandActionEnumMap = {
  CommandAction.playPause: 'playPause',
  CommandAction.scrollUpSmall: 'scrollUpSmall',
  CommandAction.scrollDownSmall: 'scrollDownSmall',
  CommandAction.scrollUp: 'scrollUp',
  CommandAction.scrollDown: 'scrollDown',
  CommandAction.pageUp: 'pageUp',
  CommandAction.pageDown: 'pageDown',
  CommandAction.jumpStart: 'jumpStart',
  CommandAction.jumpEnd: 'jumpEnd',
  CommandAction.toggleControls: 'toggleControls',
  CommandAction.speedUp: 'speedUp',
  CommandAction.speedDown: 'speedDown',
  CommandAction.fontSizeUp: 'fontSizeUp',
  CommandAction.fontSizeDown: 'fontSizeDown',
  CommandAction.openSettings: 'openSettings',
  CommandAction.saveSettingsFromPrompter: 'saveSettingsFromPrompter',
  CommandAction.jumpChapterUp: 'jumpChapterUp',
  CommandAction.jumpChapterDown: 'jumpChapterDown',
};

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);
