// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {

 ThemeMode get themeMode; Color get appPrimaryColor; Color get prompterBackgroundColor; Color get prompterTextColor; int get keybindingsMapId; PrompterConfiguration get config;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.appPrimaryColor, appPrimaryColor) || other.appPrimaryColor == appPrimaryColor)&&(identical(other.prompterBackgroundColor, prompterBackgroundColor) || other.prompterBackgroundColor == prompterBackgroundColor)&&(identical(other.prompterTextColor, prompterTextColor) || other.prompterTextColor == prompterTextColor)&&(identical(other.keybindingsMapId, keybindingsMapId) || other.keybindingsMapId == keybindingsMapId)&&(identical(other.config, config) || other.config == config));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,appPrimaryColor,prompterBackgroundColor,prompterTextColor,keybindingsMapId,config);

@override
String toString() {
  return 'SettingsState(themeMode: $themeMode, appPrimaryColor: $appPrimaryColor, prompterBackgroundColor: $prompterBackgroundColor, prompterTextColor: $prompterTextColor, keybindingsMapId: $keybindingsMapId, config: $config)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 ThemeMode themeMode, Color appPrimaryColor, Color prompterBackgroundColor, Color prompterTextColor, int keybindingsMapId, PrompterConfiguration config
});


$PrompterConfigurationCopyWith<$Res> get config;

}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? appPrimaryColor = null,Object? prompterBackgroundColor = null,Object? prompterTextColor = null,Object? keybindingsMapId = null,Object? config = null,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,appPrimaryColor: null == appPrimaryColor ? _self.appPrimaryColor : appPrimaryColor // ignore: cast_nullable_to_non_nullable
as Color,prompterBackgroundColor: null == prompterBackgroundColor ? _self.prompterBackgroundColor : prompterBackgroundColor // ignore: cast_nullable_to_non_nullable
as Color,prompterTextColor: null == prompterTextColor ? _self.prompterTextColor : prompterTextColor // ignore: cast_nullable_to_non_nullable
as Color,keybindingsMapId: null == keybindingsMapId ? _self.keybindingsMapId : keybindingsMapId // ignore: cast_nullable_to_non_nullable
as int,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as PrompterConfiguration,
  ));
}
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrompterConfigurationCopyWith<$Res> get config {
  
  return $PrompterConfigurationCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeMode themeMode,  Color appPrimaryColor,  Color prompterBackgroundColor,  Color prompterTextColor,  int keybindingsMapId,  PrompterConfiguration config)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.themeMode,_that.appPrimaryColor,_that.prompterBackgroundColor,_that.prompterTextColor,_that.keybindingsMapId,_that.config);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeMode themeMode,  Color appPrimaryColor,  Color prompterBackgroundColor,  Color prompterTextColor,  int keybindingsMapId,  PrompterConfiguration config)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.themeMode,_that.appPrimaryColor,_that.prompterBackgroundColor,_that.prompterTextColor,_that.keybindingsMapId,_that.config);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeMode themeMode,  Color appPrimaryColor,  Color prompterBackgroundColor,  Color prompterTextColor,  int keybindingsMapId,  PrompterConfiguration config)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.themeMode,_that.appPrimaryColor,_that.prompterBackgroundColor,_that.prompterTextColor,_that.keybindingsMapId,_that.config);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState extends SettingsState {
   _SettingsState({this.themeMode = ThemeMode.system, this.appPrimaryColor = kBrandTeal, this.prompterBackgroundColor = Colors.black, this.prompterTextColor = Colors.white, this.keybindingsMapId = 0, this.config = const PrompterConfiguration()}): super._();
  

@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  Color appPrimaryColor;
@override@JsonKey() final  Color prompterBackgroundColor;
@override@JsonKey() final  Color prompterTextColor;
@override@JsonKey() final  int keybindingsMapId;
@override@JsonKey() final  PrompterConfiguration config;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.appPrimaryColor, appPrimaryColor) || other.appPrimaryColor == appPrimaryColor)&&(identical(other.prompterBackgroundColor, prompterBackgroundColor) || other.prompterBackgroundColor == prompterBackgroundColor)&&(identical(other.prompterTextColor, prompterTextColor) || other.prompterTextColor == prompterTextColor)&&(identical(other.keybindingsMapId, keybindingsMapId) || other.keybindingsMapId == keybindingsMapId)&&(identical(other.config, config) || other.config == config));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,appPrimaryColor,prompterBackgroundColor,prompterTextColor,keybindingsMapId,config);

@override
String toString() {
  return 'SettingsState(themeMode: $themeMode, appPrimaryColor: $appPrimaryColor, prompterBackgroundColor: $prompterBackgroundColor, prompterTextColor: $prompterTextColor, keybindingsMapId: $keybindingsMapId, config: $config)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode themeMode, Color appPrimaryColor, Color prompterBackgroundColor, Color prompterTextColor, int keybindingsMapId, PrompterConfiguration config
});


@override $PrompterConfigurationCopyWith<$Res> get config;

}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? appPrimaryColor = null,Object? prompterBackgroundColor = null,Object? prompterTextColor = null,Object? keybindingsMapId = null,Object? config = null,}) {
  return _then(_SettingsState(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,appPrimaryColor: null == appPrimaryColor ? _self.appPrimaryColor : appPrimaryColor // ignore: cast_nullable_to_non_nullable
as Color,prompterBackgroundColor: null == prompterBackgroundColor ? _self.prompterBackgroundColor : prompterBackgroundColor // ignore: cast_nullable_to_non_nullable
as Color,prompterTextColor: null == prompterTextColor ? _self.prompterTextColor : prompterTextColor // ignore: cast_nullable_to_non_nullable
as Color,keybindingsMapId: null == keybindingsMapId ? _self.keybindingsMapId : keybindingsMapId // ignore: cast_nullable_to_non_nullable
as int,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as PrompterConfiguration,
  ));
}

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrompterConfigurationCopyWith<$Res> get config {
  
  return $PrompterConfigurationCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}

// dart format on
