// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'script_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScriptState {

 String get text; String? get title;
/// Create a copy of ScriptState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScriptStateCopyWith<ScriptState> get copyWith => _$ScriptStateCopyWithImpl<ScriptState>(this as ScriptState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScriptState&&(identical(other.text, text) || other.text == text)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,text,title);

@override
String toString() {
  return 'ScriptState(text: $text, title: $title)';
}


}

/// @nodoc
abstract mixin class $ScriptStateCopyWith<$Res>  {
  factory $ScriptStateCopyWith(ScriptState value, $Res Function(ScriptState) _then) = _$ScriptStateCopyWithImpl;
@useResult
$Res call({
 String text, String? title
});




}
/// @nodoc
class _$ScriptStateCopyWithImpl<$Res>
    implements $ScriptStateCopyWith<$Res> {
  _$ScriptStateCopyWithImpl(this._self, this._then);

  final ScriptState _self;
  final $Res Function(ScriptState) _then;

/// Create a copy of ScriptState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? title = freezed,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScriptState].
extension ScriptStatePatterns on ScriptState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScriptState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScriptState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScriptState value)  $default,){
final _that = this;
switch (_that) {
case _ScriptState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScriptState value)?  $default,){
final _that = this;
switch (_that) {
case _ScriptState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScriptState() when $default != null:
return $default(_that.text,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  String? title)  $default,) {final _that = this;
switch (_that) {
case _ScriptState():
return $default(_that.text,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  String? title)?  $default,) {final _that = this;
switch (_that) {
case _ScriptState() when $default != null:
return $default(_that.text,_that.title);case _:
  return null;

}
}

}

/// @nodoc


class _ScriptState implements ScriptState {
   _ScriptState({required this.text, required this.title});
  

@override final  String text;
@override final  String? title;

/// Create a copy of ScriptState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScriptStateCopyWith<_ScriptState> get copyWith => __$ScriptStateCopyWithImpl<_ScriptState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScriptState&&(identical(other.text, text) || other.text == text)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,text,title);

@override
String toString() {
  return 'ScriptState(text: $text, title: $title)';
}


}

/// @nodoc
abstract mixin class _$ScriptStateCopyWith<$Res> implements $ScriptStateCopyWith<$Res> {
  factory _$ScriptStateCopyWith(_ScriptState value, $Res Function(_ScriptState) _then) = __$ScriptStateCopyWithImpl;
@override @useResult
$Res call({
 String text, String? title
});




}
/// @nodoc
class __$ScriptStateCopyWithImpl<$Res>
    implements _$ScriptStateCopyWith<$Res> {
  __$ScriptStateCopyWithImpl(this._self, this._then);

  final _ScriptState _self;
  final $Res Function(_ScriptState) _then;

/// Create a copy of ScriptState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? title = freezed,}) {
  return _then(_ScriptState(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
