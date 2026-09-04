// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prompter_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrompterConfiguration {

 double get scrollSpeed; bool get mirroredX; bool get mirroredY; double get fontSize; double get sideMargin; String get fontFamily;@TextAlignConverter() TextAlign get alignment; bool get displayReadingIndicatorBoxes; double get readingIndicatorBoxesHeight; bool get displayVerticalMarginBoxes; double get verticalMarginBoxesHeight; bool get verticalMarginBoxesFadeEnabled; double get verticalMarginBoxesFadeLength; double get countdownDuration; bool get markdownEnabled; bool get showControlButtons;@ControlButtonsPositionConverter() ControlButtonsPosition get controlButtonsPosition; bool get showCurrentChapter; TextDirectionMode get textDirectionMode;
/// Create a copy of PrompterConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrompterConfigurationCopyWith<PrompterConfiguration> get copyWith => _$PrompterConfigurationCopyWithImpl<PrompterConfiguration>(this as PrompterConfiguration, _$identity);

  /// Serializes this PrompterConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PrompterConfiguration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrompterConfiguration&&(identical(other.scrollSpeed, _this.scrollSpeed) || other.scrollSpeed == _this.scrollSpeed)&&(identical(other.mirroredX, _this.mirroredX) || other.mirroredX == _this.mirroredX)&&(identical(other.mirroredY, _this.mirroredY) || other.mirroredY == _this.mirroredY)&&(identical(other.fontSize, _this.fontSize) || other.fontSize == _this.fontSize)&&(identical(other.sideMargin, _this.sideMargin) || other.sideMargin == _this.sideMargin)&&(identical(other.fontFamily, _this.fontFamily) || other.fontFamily == _this.fontFamily)&&(identical(other.alignment, _this.alignment) || other.alignment == _this.alignment)&&(identical(other.displayReadingIndicatorBoxes, _this.displayReadingIndicatorBoxes) || other.displayReadingIndicatorBoxes == _this.displayReadingIndicatorBoxes)&&(identical(other.readingIndicatorBoxesHeight, _this.readingIndicatorBoxesHeight) || other.readingIndicatorBoxesHeight == _this.readingIndicatorBoxesHeight)&&(identical(other.displayVerticalMarginBoxes, _this.displayVerticalMarginBoxes) || other.displayVerticalMarginBoxes == _this.displayVerticalMarginBoxes)&&(identical(other.verticalMarginBoxesHeight, _this.verticalMarginBoxesHeight) || other.verticalMarginBoxesHeight == _this.verticalMarginBoxesHeight)&&(identical(other.verticalMarginBoxesFadeEnabled, _this.verticalMarginBoxesFadeEnabled) || other.verticalMarginBoxesFadeEnabled == _this.verticalMarginBoxesFadeEnabled)&&(identical(other.verticalMarginBoxesFadeLength, _this.verticalMarginBoxesFadeLength) || other.verticalMarginBoxesFadeLength == _this.verticalMarginBoxesFadeLength)&&(identical(other.countdownDuration, _this.countdownDuration) || other.countdownDuration == _this.countdownDuration)&&(identical(other.markdownEnabled, _this.markdownEnabled) || other.markdownEnabled == _this.markdownEnabled)&&(identical(other.showControlButtons, _this.showControlButtons) || other.showControlButtons == _this.showControlButtons)&&(identical(other.controlButtonsPosition, _this.controlButtonsPosition) || other.controlButtonsPosition == _this.controlButtonsPosition)&&(identical(other.showCurrentChapter, _this.showCurrentChapter) || other.showCurrentChapter == _this.showCurrentChapter)&&(identical(other.textDirectionMode, _this.textDirectionMode) || other.textDirectionMode == _this.textDirectionMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PrompterConfiguration;
  return Object.hashAll([runtimeType,_this.scrollSpeed,_this.mirroredX,_this.mirroredY,_this.fontSize,_this.sideMargin,_this.fontFamily,_this.alignment,_this.displayReadingIndicatorBoxes,_this.readingIndicatorBoxesHeight,_this.displayVerticalMarginBoxes,_this.verticalMarginBoxesHeight,_this.verticalMarginBoxesFadeEnabled,_this.verticalMarginBoxesFadeLength,_this.countdownDuration,_this.markdownEnabled,_this.showControlButtons,_this.controlButtonsPosition,_this.showCurrentChapter,_this.textDirectionMode]);
}

@override
String toString() {
  final _this = this as PrompterConfiguration;
  return 'PrompterConfiguration(scrollSpeed: ${_this.scrollSpeed}, mirroredX: ${_this.mirroredX}, mirroredY: ${_this.mirroredY}, fontSize: ${_this.fontSize}, sideMargin: ${_this.sideMargin}, fontFamily: ${_this.fontFamily}, alignment: ${_this.alignment}, displayReadingIndicatorBoxes: ${_this.displayReadingIndicatorBoxes}, readingIndicatorBoxesHeight: ${_this.readingIndicatorBoxesHeight}, displayVerticalMarginBoxes: ${_this.displayVerticalMarginBoxes}, verticalMarginBoxesHeight: ${_this.verticalMarginBoxesHeight}, verticalMarginBoxesFadeEnabled: ${_this.verticalMarginBoxesFadeEnabled}, verticalMarginBoxesFadeLength: ${_this.verticalMarginBoxesFadeLength}, countdownDuration: ${_this.countdownDuration}, markdownEnabled: ${_this.markdownEnabled}, showControlButtons: ${_this.showControlButtons}, controlButtonsPosition: ${_this.controlButtonsPosition}, showCurrentChapter: ${_this.showCurrentChapter}, textDirectionMode: ${_this.textDirectionMode})';
}


}

/// @nodoc
abstract mixin class $PrompterConfigurationCopyWith<$Res>  {
  factory $PrompterConfigurationCopyWith(PrompterConfiguration value, $Res Function(PrompterConfiguration) _then) = _$PrompterConfigurationCopyWithImpl;
@useResult
$Res call({
 double scrollSpeed, bool mirroredX, bool mirroredY, double fontSize, double sideMargin, String fontFamily,@TextAlignConverter() TextAlign alignment, bool displayReadingIndicatorBoxes, double readingIndicatorBoxesHeight, bool displayVerticalMarginBoxes, double verticalMarginBoxesHeight, bool verticalMarginBoxesFadeEnabled, double verticalMarginBoxesFadeLength, double countdownDuration, bool markdownEnabled, bool showControlButtons,@ControlButtonsPositionConverter() ControlButtonsPosition controlButtonsPosition, bool showCurrentChapter, TextDirectionMode textDirectionMode
});




}
/// @nodoc
class _$PrompterConfigurationCopyWithImpl<$Res>
    implements $PrompterConfigurationCopyWith<$Res> {
  _$PrompterConfigurationCopyWithImpl(this._self, this._then);

  final PrompterConfiguration _self;
  final $Res Function(PrompterConfiguration) _then;

/// Create a copy of PrompterConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scrollSpeed = null,Object? mirroredX = null,Object? mirroredY = null,Object? fontSize = null,Object? sideMargin = null,Object? fontFamily = null,Object? alignment = null,Object? displayReadingIndicatorBoxes = null,Object? readingIndicatorBoxesHeight = null,Object? displayVerticalMarginBoxes = null,Object? verticalMarginBoxesHeight = null,Object? verticalMarginBoxesFadeEnabled = null,Object? verticalMarginBoxesFadeLength = null,Object? countdownDuration = null,Object? markdownEnabled = null,Object? showControlButtons = null,Object? controlButtonsPosition = null,Object? showCurrentChapter = null,Object? textDirectionMode = null,}) {
  return _then(PrompterConfiguration(
scrollSpeed: null == scrollSpeed ? _self.scrollSpeed : scrollSpeed // ignore: cast_nullable_to_non_nullable
as double,mirroredX: null == mirroredX ? _self.mirroredX : mirroredX // ignore: cast_nullable_to_non_nullable
as bool,mirroredY: null == mirroredY ? _self.mirroredY : mirroredY // ignore: cast_nullable_to_non_nullable
as bool,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,sideMargin: null == sideMargin ? _self.sideMargin : sideMargin // ignore: cast_nullable_to_non_nullable
as double,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,alignment: null == alignment ? _self.alignment : alignment // ignore: cast_nullable_to_non_nullable
as TextAlign,displayReadingIndicatorBoxes: null == displayReadingIndicatorBoxes ? _self.displayReadingIndicatorBoxes : displayReadingIndicatorBoxes // ignore: cast_nullable_to_non_nullable
as bool,readingIndicatorBoxesHeight: null == readingIndicatorBoxesHeight ? _self.readingIndicatorBoxesHeight : readingIndicatorBoxesHeight // ignore: cast_nullable_to_non_nullable
as double,displayVerticalMarginBoxes: null == displayVerticalMarginBoxes ? _self.displayVerticalMarginBoxes : displayVerticalMarginBoxes // ignore: cast_nullable_to_non_nullable
as bool,verticalMarginBoxesHeight: null == verticalMarginBoxesHeight ? _self.verticalMarginBoxesHeight : verticalMarginBoxesHeight // ignore: cast_nullable_to_non_nullable
as double,verticalMarginBoxesFadeEnabled: null == verticalMarginBoxesFadeEnabled ? _self.verticalMarginBoxesFadeEnabled : verticalMarginBoxesFadeEnabled // ignore: cast_nullable_to_non_nullable
as bool,verticalMarginBoxesFadeLength: null == verticalMarginBoxesFadeLength ? _self.verticalMarginBoxesFadeLength : verticalMarginBoxesFadeLength // ignore: cast_nullable_to_non_nullable
as double,countdownDuration: null == countdownDuration ? _self.countdownDuration : countdownDuration // ignore: cast_nullable_to_non_nullable
as double,markdownEnabled: null == markdownEnabled ? _self.markdownEnabled : markdownEnabled // ignore: cast_nullable_to_non_nullable
as bool,showControlButtons: null == showControlButtons ? _self.showControlButtons : showControlButtons // ignore: cast_nullable_to_non_nullable
as bool,controlButtonsPosition: null == controlButtonsPosition ? _self.controlButtonsPosition : controlButtonsPosition // ignore: cast_nullable_to_non_nullable
as ControlButtonsPosition,showCurrentChapter: null == showCurrentChapter ? _self.showCurrentChapter : showCurrentChapter // ignore: cast_nullable_to_non_nullable
as bool,textDirectionMode: null == textDirectionMode ? _self.textDirectionMode : textDirectionMode // ignore: cast_nullable_to_non_nullable
as TextDirectionMode,
  ));
}

}


/// Adds pattern-matching-related methods to [PrompterConfiguration].
extension PrompterConfigurationPatterns on PrompterConfiguration {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrompterConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrompterConfiguration() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrompterConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _PrompterConfiguration():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrompterConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _PrompterConfiguration() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double scrollSpeed,  bool mirroredX,  bool mirroredY,  double fontSize,  double sideMargin,  String fontFamily, @TextAlignConverter()  TextAlign alignment,  bool displayReadingIndicatorBoxes,  double readingIndicatorBoxesHeight,  bool displayVerticalMarginBoxes,  double verticalMarginBoxesHeight,  bool verticalMarginBoxesFadeEnabled,  double verticalMarginBoxesFadeLength,  double countdownDuration,  bool markdownEnabled,  bool showControlButtons, @ControlButtonsPositionConverter()  ControlButtonsPosition controlButtonsPosition,  bool showCurrentChapter,  TextDirectionMode textDirectionMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrompterConfiguration() when $default != null:
return $default(_that.scrollSpeed,_that.mirroredX,_that.mirroredY,_that.fontSize,_that.sideMargin,_that.fontFamily,_that.alignment,_that.displayReadingIndicatorBoxes,_that.readingIndicatorBoxesHeight,_that.displayVerticalMarginBoxes,_that.verticalMarginBoxesHeight,_that.verticalMarginBoxesFadeEnabled,_that.verticalMarginBoxesFadeLength,_that.countdownDuration,_that.markdownEnabled,_that.showControlButtons,_that.controlButtonsPosition,_that.showCurrentChapter,_that.textDirectionMode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double scrollSpeed,  bool mirroredX,  bool mirroredY,  double fontSize,  double sideMargin,  String fontFamily, @TextAlignConverter()  TextAlign alignment,  bool displayReadingIndicatorBoxes,  double readingIndicatorBoxesHeight,  bool displayVerticalMarginBoxes,  double verticalMarginBoxesHeight,  bool verticalMarginBoxesFadeEnabled,  double verticalMarginBoxesFadeLength,  double countdownDuration,  bool markdownEnabled,  bool showControlButtons, @ControlButtonsPositionConverter()  ControlButtonsPosition controlButtonsPosition,  bool showCurrentChapter,  TextDirectionMode textDirectionMode)  $default,) {final _that = this;
switch (_that) {
case _PrompterConfiguration():
return $default(_that.scrollSpeed,_that.mirroredX,_that.mirroredY,_that.fontSize,_that.sideMargin,_that.fontFamily,_that.alignment,_that.displayReadingIndicatorBoxes,_that.readingIndicatorBoxesHeight,_that.displayVerticalMarginBoxes,_that.verticalMarginBoxesHeight,_that.verticalMarginBoxesFadeEnabled,_that.verticalMarginBoxesFadeLength,_that.countdownDuration,_that.markdownEnabled,_that.showControlButtons,_that.controlButtonsPosition,_that.showCurrentChapter,_that.textDirectionMode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double scrollSpeed,  bool mirroredX,  bool mirroredY,  double fontSize,  double sideMargin,  String fontFamily, @TextAlignConverter()  TextAlign alignment,  bool displayReadingIndicatorBoxes,  double readingIndicatorBoxesHeight,  bool displayVerticalMarginBoxes,  double verticalMarginBoxesHeight,  bool verticalMarginBoxesFadeEnabled,  double verticalMarginBoxesFadeLength,  double countdownDuration,  bool markdownEnabled,  bool showControlButtons, @ControlButtonsPositionConverter()  ControlButtonsPosition controlButtonsPosition,  bool showCurrentChapter,  TextDirectionMode textDirectionMode)?  $default,) {final _that = this;
switch (_that) {
case _PrompterConfiguration() when $default != null:
return $default(_that.scrollSpeed,_that.mirroredX,_that.mirroredY,_that.fontSize,_that.sideMargin,_that.fontFamily,_that.alignment,_that.displayReadingIndicatorBoxes,_that.readingIndicatorBoxesHeight,_that.displayVerticalMarginBoxes,_that.verticalMarginBoxesHeight,_that.verticalMarginBoxesFadeEnabled,_that.verticalMarginBoxesFadeLength,_that.countdownDuration,_that.markdownEnabled,_that.showControlButtons,_that.controlButtonsPosition,_that.showCurrentChapter,_that.textDirectionMode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrompterConfiguration extends PrompterConfiguration {
  const _PrompterConfiguration({this.scrollSpeed = 1.0, this.mirroredX = false, this.mirroredY = false, this.fontSize = 42.0, this.sideMargin = 0.0, this.fontFamily = 'Roboto', @TextAlignConverter() this.alignment = TextAlign.left, this.displayReadingIndicatorBoxes = false, this.readingIndicatorBoxesHeight = 60.0, this.displayVerticalMarginBoxes = false, this.verticalMarginBoxesHeight = 35.0, this.verticalMarginBoxesFadeEnabled = false, this.verticalMarginBoxesFadeLength = 50.0, this.countdownDuration = 0.0, this.markdownEnabled = false, this.showControlButtons = false, @ControlButtonsPositionConverter() this.controlButtonsPosition = ControlButtonsPosition.left, this.showCurrentChapter = false, this.textDirectionMode = TextDirectionMode.auto}): super._();
  factory _PrompterConfiguration.fromJson(Map<String, dynamic> json) => _$PrompterConfigurationFromJson(json);

@override@JsonKey() final  double scrollSpeed;
@override@JsonKey() final  bool mirroredX;
@override@JsonKey() final  bool mirroredY;
@override@JsonKey() final  double fontSize;
@override@JsonKey() final  double sideMargin;
@override@JsonKey() final  String fontFamily;
@override@JsonKey()@TextAlignConverter() final  TextAlign alignment;
@override@JsonKey() final  bool displayReadingIndicatorBoxes;
@override@JsonKey() final  double readingIndicatorBoxesHeight;
@override@JsonKey() final  bool displayVerticalMarginBoxes;
@override@JsonKey() final  double verticalMarginBoxesHeight;
@override@JsonKey() final  bool verticalMarginBoxesFadeEnabled;
@override@JsonKey() final  double verticalMarginBoxesFadeLength;
@override@JsonKey() final  double countdownDuration;
@override@JsonKey() final  bool markdownEnabled;
@override@JsonKey() final  bool showControlButtons;
@override@JsonKey()@ControlButtonsPositionConverter() final  ControlButtonsPosition controlButtonsPosition;
@override@JsonKey() final  bool showCurrentChapter;
@override@JsonKey() final  TextDirectionMode textDirectionMode;

/// Create a copy of PrompterConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrompterConfigurationCopyWith<_PrompterConfiguration> get copyWith => __$PrompterConfigurationCopyWithImpl<_PrompterConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrompterConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrompterConfiguration&&(identical(other.scrollSpeed, scrollSpeed) || other.scrollSpeed == scrollSpeed)&&(identical(other.mirroredX, mirroredX) || other.mirroredX == mirroredX)&&(identical(other.mirroredY, mirroredY) || other.mirroredY == mirroredY)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.sideMargin, sideMargin) || other.sideMargin == sideMargin)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.alignment, alignment) || other.alignment == alignment)&&(identical(other.displayReadingIndicatorBoxes, displayReadingIndicatorBoxes) || other.displayReadingIndicatorBoxes == displayReadingIndicatorBoxes)&&(identical(other.readingIndicatorBoxesHeight, readingIndicatorBoxesHeight) || other.readingIndicatorBoxesHeight == readingIndicatorBoxesHeight)&&(identical(other.displayVerticalMarginBoxes, displayVerticalMarginBoxes) || other.displayVerticalMarginBoxes == displayVerticalMarginBoxes)&&(identical(other.verticalMarginBoxesHeight, verticalMarginBoxesHeight) || other.verticalMarginBoxesHeight == verticalMarginBoxesHeight)&&(identical(other.verticalMarginBoxesFadeEnabled, verticalMarginBoxesFadeEnabled) || other.verticalMarginBoxesFadeEnabled == verticalMarginBoxesFadeEnabled)&&(identical(other.verticalMarginBoxesFadeLength, verticalMarginBoxesFadeLength) || other.verticalMarginBoxesFadeLength == verticalMarginBoxesFadeLength)&&(identical(other.countdownDuration, countdownDuration) || other.countdownDuration == countdownDuration)&&(identical(other.markdownEnabled, markdownEnabled) || other.markdownEnabled == markdownEnabled)&&(identical(other.showControlButtons, showControlButtons) || other.showControlButtons == showControlButtons)&&(identical(other.controlButtonsPosition, controlButtonsPosition) || other.controlButtonsPosition == controlButtonsPosition)&&(identical(other.showCurrentChapter, showCurrentChapter) || other.showCurrentChapter == showCurrentChapter)&&(identical(other.textDirectionMode, textDirectionMode) || other.textDirectionMode == textDirectionMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,scrollSpeed,mirroredX,mirroredY,fontSize,sideMargin,fontFamily,alignment,displayReadingIndicatorBoxes,readingIndicatorBoxesHeight,displayVerticalMarginBoxes,verticalMarginBoxesHeight,verticalMarginBoxesFadeEnabled,verticalMarginBoxesFadeLength,countdownDuration,markdownEnabled,showControlButtons,controlButtonsPosition,showCurrentChapter,textDirectionMode]);
}

@override
String toString() {
    return 'PrompterConfiguration(scrollSpeed: $scrollSpeed, mirroredX: $mirroredX, mirroredY: $mirroredY, fontSize: $fontSize, sideMargin: $sideMargin, fontFamily: $fontFamily, alignment: $alignment, displayReadingIndicatorBoxes: $displayReadingIndicatorBoxes, readingIndicatorBoxesHeight: $readingIndicatorBoxesHeight, displayVerticalMarginBoxes: $displayVerticalMarginBoxes, verticalMarginBoxesHeight: $verticalMarginBoxesHeight, verticalMarginBoxesFadeEnabled: $verticalMarginBoxesFadeEnabled, verticalMarginBoxesFadeLength: $verticalMarginBoxesFadeLength, countdownDuration: $countdownDuration, markdownEnabled: $markdownEnabled, showControlButtons: $showControlButtons, controlButtonsPosition: $controlButtonsPosition, showCurrentChapter: $showCurrentChapter, textDirectionMode: $textDirectionMode)';
}


}

/// @nodoc
abstract mixin class _$PrompterConfigurationCopyWith<$Res> implements $PrompterConfigurationCopyWith<$Res> {
  factory _$PrompterConfigurationCopyWith(_PrompterConfiguration value, $Res Function(_PrompterConfiguration) _then) = __$PrompterConfigurationCopyWithImpl;
@override @useResult
$Res call({
 double scrollSpeed, bool mirroredX, bool mirroredY, double fontSize, double sideMargin, String fontFamily,@TextAlignConverter() TextAlign alignment, bool displayReadingIndicatorBoxes, double readingIndicatorBoxesHeight, bool displayVerticalMarginBoxes, double verticalMarginBoxesHeight, bool verticalMarginBoxesFadeEnabled, double verticalMarginBoxesFadeLength, double countdownDuration, bool markdownEnabled, bool showControlButtons,@ControlButtonsPositionConverter() ControlButtonsPosition controlButtonsPosition, bool showCurrentChapter, TextDirectionMode textDirectionMode
});




}
/// @nodoc
class __$PrompterConfigurationCopyWithImpl<$Res>
    implements _$PrompterConfigurationCopyWith<$Res> {
  __$PrompterConfigurationCopyWithImpl(this._self, this._then);

  final _PrompterConfiguration _self;
  final $Res Function(_PrompterConfiguration) _then;

/// Create a copy of PrompterConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scrollSpeed = null,Object? mirroredX = null,Object? mirroredY = null,Object? fontSize = null,Object? sideMargin = null,Object? fontFamily = null,Object? alignment = null,Object? displayReadingIndicatorBoxes = null,Object? readingIndicatorBoxesHeight = null,Object? displayVerticalMarginBoxes = null,Object? verticalMarginBoxesHeight = null,Object? verticalMarginBoxesFadeEnabled = null,Object? verticalMarginBoxesFadeLength = null,Object? countdownDuration = null,Object? markdownEnabled = null,Object? showControlButtons = null,Object? controlButtonsPosition = null,Object? showCurrentChapter = null,Object? textDirectionMode = null,}) {
  return _then(_PrompterConfiguration(
scrollSpeed: null == scrollSpeed ? _self.scrollSpeed : scrollSpeed // ignore: cast_nullable_to_non_nullable
as double,mirroredX: null == mirroredX ? _self.mirroredX : mirroredX // ignore: cast_nullable_to_non_nullable
as bool,mirroredY: null == mirroredY ? _self.mirroredY : mirroredY // ignore: cast_nullable_to_non_nullable
as bool,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,sideMargin: null == sideMargin ? _self.sideMargin : sideMargin // ignore: cast_nullable_to_non_nullable
as double,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,alignment: null == alignment ? _self.alignment : alignment // ignore: cast_nullable_to_non_nullable
as TextAlign,displayReadingIndicatorBoxes: null == displayReadingIndicatorBoxes ? _self.displayReadingIndicatorBoxes : displayReadingIndicatorBoxes // ignore: cast_nullable_to_non_nullable
as bool,readingIndicatorBoxesHeight: null == readingIndicatorBoxesHeight ? _self.readingIndicatorBoxesHeight : readingIndicatorBoxesHeight // ignore: cast_nullable_to_non_nullable
as double,displayVerticalMarginBoxes: null == displayVerticalMarginBoxes ? _self.displayVerticalMarginBoxes : displayVerticalMarginBoxes // ignore: cast_nullable_to_non_nullable
as bool,verticalMarginBoxesHeight: null == verticalMarginBoxesHeight ? _self.verticalMarginBoxesHeight : verticalMarginBoxesHeight // ignore: cast_nullable_to_non_nullable
as double,verticalMarginBoxesFadeEnabled: null == verticalMarginBoxesFadeEnabled ? _self.verticalMarginBoxesFadeEnabled : verticalMarginBoxesFadeEnabled // ignore: cast_nullable_to_non_nullable
as bool,verticalMarginBoxesFadeLength: null == verticalMarginBoxesFadeLength ? _self.verticalMarginBoxesFadeLength : verticalMarginBoxesFadeLength // ignore: cast_nullable_to_non_nullable
as double,countdownDuration: null == countdownDuration ? _self.countdownDuration : countdownDuration // ignore: cast_nullable_to_non_nullable
as double,markdownEnabled: null == markdownEnabled ? _self.markdownEnabled : markdownEnabled // ignore: cast_nullable_to_non_nullable
as bool,showControlButtons: null == showControlButtons ? _self.showControlButtons : showControlButtons // ignore: cast_nullable_to_non_nullable
as bool,controlButtonsPosition: null == controlButtonsPosition ? _self.controlButtonsPosition : controlButtonsPosition // ignore: cast_nullable_to_non_nullable
as ControlButtonsPosition,showCurrentChapter: null == showCurrentChapter ? _self.showCurrentChapter : showCurrentChapter // ignore: cast_nullable_to_non_nullable
as bool,textDirectionMode: null == textDirectionMode ? _self.textDirectionMode : textDirectionMode // ignore: cast_nullable_to_non_nullable
as TextDirectionMode,
  ));
}


}

// dart format on
