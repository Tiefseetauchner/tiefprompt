// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_chapter_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrentChapterState {

 String get chapterText; double get chapterOffset;
/// Create a copy of CurrentChapterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentChapterStateCopyWith<CurrentChapterState> get copyWith => _$CurrentChapterStateCopyWithImpl<CurrentChapterState>(this as CurrentChapterState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CurrentChapterState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentChapterState&&(identical(other.chapterText, _this.chapterText) || other.chapterText == _this.chapterText)&&(identical(other.chapterOffset, _this.chapterOffset) || other.chapterOffset == _this.chapterOffset));
}


@override
int get hashCode {
  final _this = this as CurrentChapterState;
  return Object.hash(runtimeType,_this.chapterText,_this.chapterOffset);
}

@override
String toString() {
  final _this = this as CurrentChapterState;
  return 'CurrentChapterState(chapterText: ${_this.chapterText}, chapterOffset: ${_this.chapterOffset})';
}


}

/// @nodoc
abstract mixin class $CurrentChapterStateCopyWith<$Res>  {
  factory $CurrentChapterStateCopyWith(CurrentChapterState value, $Res Function(CurrentChapterState) _then) = _$CurrentChapterStateCopyWithImpl;
@useResult
$Res call({
 String chapterText, double chapterOffset
});




}
/// @nodoc
class _$CurrentChapterStateCopyWithImpl<$Res>
    implements $CurrentChapterStateCopyWith<$Res> {
  _$CurrentChapterStateCopyWithImpl(this._self, this._then);

  final CurrentChapterState _self;
  final $Res Function(CurrentChapterState) _then;

/// Create a copy of CurrentChapterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chapterText = null,Object? chapterOffset = null,}) {
  return _then(CurrentChapterState(
null == chapterText ? _self.chapterText : chapterText // ignore: cast_nullable_to_non_nullable
as String,null == chapterOffset ? _self.chapterOffset : chapterOffset // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentChapterState].
extension CurrentChapterStatePatterns on CurrentChapterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentChapterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentChapterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentChapterState value)  $default,){
final _that = this;
switch (_that) {
case _CurrentChapterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentChapterState value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentChapterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chapterText,  double chapterOffset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentChapterState() when $default != null:
return $default(_that.chapterText,_that.chapterOffset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chapterText,  double chapterOffset)  $default,) {final _that = this;
switch (_that) {
case _CurrentChapterState():
return $default(_that.chapterText,_that.chapterOffset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chapterText,  double chapterOffset)?  $default,) {final _that = this;
switch (_that) {
case _CurrentChapterState() when $default != null:
return $default(_that.chapterText,_that.chapterOffset);case _:
  return null;

}
}

}

/// @nodoc


class _CurrentChapterState implements CurrentChapterState {
   _CurrentChapterState(this.chapterText, this.chapterOffset);
  

@override final  String chapterText;
@override final  double chapterOffset;

/// Create a copy of CurrentChapterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentChapterStateCopyWith<_CurrentChapterState> get copyWith => __$CurrentChapterStateCopyWithImpl<_CurrentChapterState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentChapterState&&(identical(other.chapterText, chapterText) || other.chapterText == chapterText)&&(identical(other.chapterOffset, chapterOffset) || other.chapterOffset == chapterOffset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,chapterText,chapterOffset);
}

@override
String toString() {
    return 'CurrentChapterState(chapterText: $chapterText, chapterOffset: $chapterOffset)';
}


}

/// @nodoc
abstract mixin class _$CurrentChapterStateCopyWith<$Res> implements $CurrentChapterStateCopyWith<$Res> {
  factory _$CurrentChapterStateCopyWith(_CurrentChapterState value, $Res Function(_CurrentChapterState) _then) = __$CurrentChapterStateCopyWithImpl;
@override @useResult
$Res call({
 String chapterText, double chapterOffset
});




}
/// @nodoc
class __$CurrentChapterStateCopyWithImpl<$Res>
    implements _$CurrentChapterStateCopyWith<$Res> {
  __$CurrentChapterStateCopyWithImpl(this._self, this._then);

  final _CurrentChapterState _self;
  final $Res Function(_CurrentChapterState) _then;

/// Create a copy of CurrentChapterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chapterText = null,Object? chapterOffset = null,}) {
  return _then(_CurrentChapterState(
null == chapterText ? _self.chapterText : chapterText // ignore: cast_nullable_to_non_nullable
as String,null == chapterOffset ? _self.chapterOffset : chapterOffset // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
