// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ThemesState {

 ThemeData get darkTheme; ThemeData get lightTheme; ThemeData get prompterTheme;
/// Create a copy of ThemesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemesStateCopyWith<ThemesState> get copyWith => _$ThemesStateCopyWithImpl<ThemesState>(this as ThemesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemesState&&(identical(other.darkTheme, darkTheme) || other.darkTheme == darkTheme)&&(identical(other.lightTheme, lightTheme) || other.lightTheme == lightTheme)&&(identical(other.prompterTheme, prompterTheme) || other.prompterTheme == prompterTheme));
}


@override
int get hashCode => Object.hash(runtimeType,darkTheme,lightTheme,prompterTheme);

@override
String toString() {
  return 'ThemesState(darkTheme: $darkTheme, lightTheme: $lightTheme, prompterTheme: $prompterTheme)';
}


}

/// @nodoc
abstract mixin class $ThemesStateCopyWith<$Res>  {
  factory $ThemesStateCopyWith(ThemesState value, $Res Function(ThemesState) _then) = _$ThemesStateCopyWithImpl;
@useResult
$Res call({
 ThemeData darkTheme, ThemeData lightTheme, ThemeData prompterTheme
});




}
/// @nodoc
class _$ThemesStateCopyWithImpl<$Res>
    implements $ThemesStateCopyWith<$Res> {
  _$ThemesStateCopyWithImpl(this._self, this._then);

  final ThemesState _self;
  final $Res Function(ThemesState) _then;

/// Create a copy of ThemesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? darkTheme = null,Object? lightTheme = null,Object? prompterTheme = null,}) {
  return _then(_self.copyWith(
darkTheme: null == darkTheme ? _self.darkTheme : darkTheme // ignore: cast_nullable_to_non_nullable
as ThemeData,lightTheme: null == lightTheme ? _self.lightTheme : lightTheme // ignore: cast_nullable_to_non_nullable
as ThemeData,prompterTheme: null == prompterTheme ? _self.prompterTheme : prompterTheme // ignore: cast_nullable_to_non_nullable
as ThemeData,
  ));
}

}


/// Adds pattern-matching-related methods to [ThemesState].
extension ThemesStatePatterns on ThemesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThemesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThemesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThemesState value)  $default,){
final _that = this;
switch (_that) {
case _ThemesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThemesState value)?  $default,){
final _that = this;
switch (_that) {
case _ThemesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeData darkTheme,  ThemeData lightTheme,  ThemeData prompterTheme)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThemesState() when $default != null:
return $default(_that.darkTheme,_that.lightTheme,_that.prompterTheme);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeData darkTheme,  ThemeData lightTheme,  ThemeData prompterTheme)  $default,) {final _that = this;
switch (_that) {
case _ThemesState():
return $default(_that.darkTheme,_that.lightTheme,_that.prompterTheme);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeData darkTheme,  ThemeData lightTheme,  ThemeData prompterTheme)?  $default,) {final _that = this;
switch (_that) {
case _ThemesState() when $default != null:
return $default(_that.darkTheme,_that.lightTheme,_that.prompterTheme);case _:
  return null;

}
}

}

/// @nodoc


class _ThemesState implements ThemesState {
   _ThemesState({required this.darkTheme, required this.lightTheme, required this.prompterTheme});
  

@override final  ThemeData darkTheme;
@override final  ThemeData lightTheme;
@override final  ThemeData prompterTheme;

/// Create a copy of ThemesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemesStateCopyWith<_ThemesState> get copyWith => __$ThemesStateCopyWithImpl<_ThemesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemesState&&(identical(other.darkTheme, darkTheme) || other.darkTheme == darkTheme)&&(identical(other.lightTheme, lightTheme) || other.lightTheme == lightTheme)&&(identical(other.prompterTheme, prompterTheme) || other.prompterTheme == prompterTheme));
}


@override
int get hashCode => Object.hash(runtimeType,darkTheme,lightTheme,prompterTheme);

@override
String toString() {
  return 'ThemesState(darkTheme: $darkTheme, lightTheme: $lightTheme, prompterTheme: $prompterTheme)';
}


}

/// @nodoc
abstract mixin class _$ThemesStateCopyWith<$Res> implements $ThemesStateCopyWith<$Res> {
  factory _$ThemesStateCopyWith(_ThemesState value, $Res Function(_ThemesState) _then) = __$ThemesStateCopyWithImpl;
@override @useResult
$Res call({
 ThemeData darkTheme, ThemeData lightTheme, ThemeData prompterTheme
});




}
/// @nodoc
class __$ThemesStateCopyWithImpl<$Res>
    implements _$ThemesStateCopyWith<$Res> {
  __$ThemesStateCopyWithImpl(this._self, this._then);

  final _ThemesState _self;
  final $Res Function(_ThemesState) _then;

/// Create a copy of ThemesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? darkTheme = null,Object? lightTheme = null,Object? prompterTheme = null,}) {
  return _then(_ThemesState(
darkTheme: null == darkTheme ? _self.darkTheme : darkTheme // ignore: cast_nullable_to_non_nullable
as ThemeData,lightTheme: null == lightTheme ? _self.lightTheme : lightTheme // ignore: cast_nullable_to_non_nullable
as ThemeData,prompterTheme: null == prompterTheme ? _self.prompterTheme : prompterTheme // ignore: cast_nullable_to_non_nullable
as ThemeData,
  ));
}


}

// dart format on
