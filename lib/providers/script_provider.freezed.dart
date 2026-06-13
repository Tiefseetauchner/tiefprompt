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

 int? get id; String get text; String? get title; bool get isSaved; double? get scrollPosition; bool get ephemeral;
/// Create a copy of ScriptState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScriptStateCopyWith<ScriptState> get copyWith => _$ScriptStateCopyWithImpl<ScriptState>(this as ScriptState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScriptState&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.title, title) || other.title == title)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved)&&(identical(other.scrollPosition, scrollPosition) || other.scrollPosition == scrollPosition)&&(identical(other.ephemeral, ephemeral) || other.ephemeral == ephemeral));
}


@override
int get hashCode => Object.hash(runtimeType,id,text,title,isSaved,scrollPosition,ephemeral);

@override
String toString() {
  return 'ScriptState(id: $id, text: $text, title: $title, isSaved: $isSaved, scrollPosition: $scrollPosition, ephemeral: $ephemeral)';
}


}

/// @nodoc
abstract mixin class $ScriptStateCopyWith<$Res>  {
  factory $ScriptStateCopyWith(ScriptState value, $Res Function(ScriptState) _then) = _$ScriptStateCopyWithImpl;
@useResult
$Res call({
 int? id, String text, String? title, bool isSaved, double? scrollPosition, bool ephemeral
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? text = null,Object? title = freezed,Object? isSaved = null,Object? scrollPosition = freezed,Object? ephemeral = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,scrollPosition: freezed == scrollPosition ? _self.scrollPosition : scrollPosition // ignore: cast_nullable_to_non_nullable
as double?,ephemeral: null == ephemeral ? _self.ephemeral : ephemeral // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String text,  String? title,  bool isSaved,  double? scrollPosition,  bool ephemeral)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScriptState() when $default != null:
return $default(_that.id,_that.text,_that.title,_that.isSaved,_that.scrollPosition,_that.ephemeral);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String text,  String? title,  bool isSaved,  double? scrollPosition,  bool ephemeral)  $default,) {final _that = this;
switch (_that) {
case _ScriptState():
return $default(_that.id,_that.text,_that.title,_that.isSaved,_that.scrollPosition,_that.ephemeral);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String text,  String? title,  bool isSaved,  double? scrollPosition,  bool ephemeral)?  $default,) {final _that = this;
switch (_that) {
case _ScriptState() when $default != null:
return $default(_that.id,_that.text,_that.title,_that.isSaved,_that.scrollPosition,_that.ephemeral);case _:
  return null;

}
}

}

/// @nodoc


class _ScriptState implements ScriptState {
   _ScriptState({required this.id, required this.text, required this.title, required this.isSaved, required this.scrollPosition, required this.ephemeral});
  

@override final  int? id;
@override final  String text;
@override final  String? title;
@override final  bool isSaved;
@override final  double? scrollPosition;
@override final  bool ephemeral;

/// Create a copy of ScriptState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScriptStateCopyWith<_ScriptState> get copyWith => __$ScriptStateCopyWithImpl<_ScriptState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScriptState&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.title, title) || other.title == title)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved)&&(identical(other.scrollPosition, scrollPosition) || other.scrollPosition == scrollPosition)&&(identical(other.ephemeral, ephemeral) || other.ephemeral == ephemeral));
}


@override
int get hashCode => Object.hash(runtimeType,id,text,title,isSaved,scrollPosition,ephemeral);

@override
String toString() {
  return 'ScriptState(id: $id, text: $text, title: $title, isSaved: $isSaved, scrollPosition: $scrollPosition, ephemeral: $ephemeral)';
}


}

/// @nodoc
abstract mixin class _$ScriptStateCopyWith<$Res> implements $ScriptStateCopyWith<$Res> {
  factory _$ScriptStateCopyWith(_ScriptState value, $Res Function(_ScriptState) _then) = __$ScriptStateCopyWithImpl;
@override @useResult
$Res call({
 int? id, String text, String? title, bool isSaved, double? scrollPosition, bool ephemeral
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? text = null,Object? title = freezed,Object? isSaved = null,Object? scrollPosition = freezed,Object? ephemeral = null,}) {
  return _then(_ScriptState(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,scrollPosition: freezed == scrollPosition ? _self.scrollPosition : scrollPosition // ignore: cast_nullable_to_non_nullable
as double?,ephemeral: null == ephemeral ? _self.ephemeral : ephemeral // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
