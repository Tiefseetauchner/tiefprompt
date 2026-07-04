// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keybinding.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Keybinding {

 int get keyId; bool get ctrl; bool get shift; bool get alt; bool get meta;
/// Create a copy of Keybinding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeybindingCopyWith<Keybinding> get copyWith => _$KeybindingCopyWithImpl<Keybinding>(this as Keybinding, _$identity);

  /// Serializes this Keybinding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Keybinding&&(identical(other.keyId, keyId) || other.keyId == keyId)&&(identical(other.ctrl, ctrl) || other.ctrl == ctrl)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.alt, alt) || other.alt == alt)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,keyId,ctrl,shift,alt,meta);

@override
String toString() {
  return 'Keybinding(keyId: $keyId, ctrl: $ctrl, shift: $shift, alt: $alt, meta: $meta)';
}


}

/// @nodoc
abstract mixin class $KeybindingCopyWith<$Res>  {
  factory $KeybindingCopyWith(Keybinding value, $Res Function(Keybinding) _then) = _$KeybindingCopyWithImpl;
@useResult
$Res call({
 int keyId, bool ctrl, bool shift, bool alt, bool meta
});




}
/// @nodoc
class _$KeybindingCopyWithImpl<$Res>
    implements $KeybindingCopyWith<$Res> {
  _$KeybindingCopyWithImpl(this._self, this._then);

  final Keybinding _self;
  final $Res Function(Keybinding) _then;

/// Create a copy of Keybinding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keyId = null,Object? ctrl = null,Object? shift = null,Object? alt = null,Object? meta = null,}) {
  return _then(_self.copyWith(
keyId: null == keyId ? _self.keyId : keyId // ignore: cast_nullable_to_non_nullable
as int,ctrl: null == ctrl ? _self.ctrl : ctrl // ignore: cast_nullable_to_non_nullable
as bool,shift: null == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as bool,alt: null == alt ? _self.alt : alt // ignore: cast_nullable_to_non_nullable
as bool,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Keybinding].
extension KeybindingPatterns on Keybinding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Keybinding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Keybinding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Keybinding value)  $default,){
final _that = this;
switch (_that) {
case _Keybinding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Keybinding value)?  $default,){
final _that = this;
switch (_that) {
case _Keybinding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int keyId,  bool ctrl,  bool shift,  bool alt,  bool meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Keybinding() when $default != null:
return $default(_that.keyId,_that.ctrl,_that.shift,_that.alt,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int keyId,  bool ctrl,  bool shift,  bool alt,  bool meta)  $default,) {final _that = this;
switch (_that) {
case _Keybinding():
return $default(_that.keyId,_that.ctrl,_that.shift,_that.alt,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int keyId,  bool ctrl,  bool shift,  bool alt,  bool meta)?  $default,) {final _that = this;
switch (_that) {
case _Keybinding() when $default != null:
return $default(_that.keyId,_that.ctrl,_that.shift,_that.alt,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Keybinding extends Keybinding {
   _Keybinding({required this.keyId, this.ctrl = false, this.shift = false, this.alt = false, this.meta = false}): super._();
  factory _Keybinding.fromJson(Map<String, dynamic> json) => _$KeybindingFromJson(json);

@override final  int keyId;
@override@JsonKey() final  bool ctrl;
@override@JsonKey() final  bool shift;
@override@JsonKey() final  bool alt;
@override@JsonKey() final  bool meta;

/// Create a copy of Keybinding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeybindingCopyWith<_Keybinding> get copyWith => __$KeybindingCopyWithImpl<_Keybinding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KeybindingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Keybinding&&(identical(other.keyId, keyId) || other.keyId == keyId)&&(identical(other.ctrl, ctrl) || other.ctrl == ctrl)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.alt, alt) || other.alt == alt)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,keyId,ctrl,shift,alt,meta);

@override
String toString() {
  return 'Keybinding(keyId: $keyId, ctrl: $ctrl, shift: $shift, alt: $alt, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$KeybindingCopyWith<$Res> implements $KeybindingCopyWith<$Res> {
  factory _$KeybindingCopyWith(_Keybinding value, $Res Function(_Keybinding) _then) = __$KeybindingCopyWithImpl;
@override @useResult
$Res call({
 int keyId, bool ctrl, bool shift, bool alt, bool meta
});




}
/// @nodoc
class __$KeybindingCopyWithImpl<$Res>
    implements _$KeybindingCopyWith<$Res> {
  __$KeybindingCopyWithImpl(this._self, this._then);

  final _Keybinding _self;
  final $Res Function(_Keybinding) _then;

/// Create a copy of Keybinding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keyId = null,Object? ctrl = null,Object? shift = null,Object? alt = null,Object? meta = null,}) {
  return _then(_Keybinding(
keyId: null == keyId ? _self.keyId : keyId // ignore: cast_nullable_to_non_nullable
as int,ctrl: null == ctrl ? _self.ctrl : ctrl // ignore: cast_nullable_to_non_nullable
as bool,shift: null == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as bool,alt: null == alt ? _self.alt : alt // ignore: cast_nullable_to_non_nullable
as bool,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$KeybindingMap {

 List<(KeybindingAction, Keybinding)> get keybindings;
/// Create a copy of KeybindingMap
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeybindingMapCopyWith<KeybindingMap> get copyWith => _$KeybindingMapCopyWithImpl<KeybindingMap>(this as KeybindingMap, _$identity);

  /// Serializes this KeybindingMap to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeybindingMap&&const DeepCollectionEquality().equals(other.keybindings, keybindings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(keybindings));

@override
String toString() {
  return 'KeybindingMap(keybindings: $keybindings)';
}


}

/// @nodoc
abstract mixin class $KeybindingMapCopyWith<$Res>  {
  factory $KeybindingMapCopyWith(KeybindingMap value, $Res Function(KeybindingMap) _then) = _$KeybindingMapCopyWithImpl;
@useResult
$Res call({
 List<(KeybindingAction, Keybinding)> keybindings
});




}
/// @nodoc
class _$KeybindingMapCopyWithImpl<$Res>
    implements $KeybindingMapCopyWith<$Res> {
  _$KeybindingMapCopyWithImpl(this._self, this._then);

  final KeybindingMap _self;
  final $Res Function(KeybindingMap) _then;

/// Create a copy of KeybindingMap
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keybindings = null,}) {
  return _then(_self.copyWith(
keybindings: null == keybindings ? _self.keybindings : keybindings // ignore: cast_nullable_to_non_nullable
as List<(KeybindingAction, Keybinding)>,
  ));
}

}


/// Adds pattern-matching-related methods to [KeybindingMap].
extension KeybindingMapPatterns on KeybindingMap {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeybindingMap value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeybindingMap() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeybindingMap value)  $default,){
final _that = this;
switch (_that) {
case _KeybindingMap():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeybindingMap value)?  $default,){
final _that = this;
switch (_that) {
case _KeybindingMap() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<(KeybindingAction, Keybinding)> keybindings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeybindingMap() when $default != null:
return $default(_that.keybindings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<(KeybindingAction, Keybinding)> keybindings)  $default,) {final _that = this;
switch (_that) {
case _KeybindingMap():
return $default(_that.keybindings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<(KeybindingAction, Keybinding)> keybindings)?  $default,) {final _that = this;
switch (_that) {
case _KeybindingMap() when $default != null:
return $default(_that.keybindings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KeybindingMap implements KeybindingMap {
   _KeybindingMap({required final  List<(KeybindingAction, Keybinding)> keybindings}): _keybindings = keybindings;
  factory _KeybindingMap.fromJson(Map<String, dynamic> json) => _$KeybindingMapFromJson(json);

 final  List<(KeybindingAction, Keybinding)> _keybindings;
@override List<(KeybindingAction, Keybinding)> get keybindings {
  if (_keybindings is EqualUnmodifiableListView) return _keybindings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keybindings);
}


/// Create a copy of KeybindingMap
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeybindingMapCopyWith<_KeybindingMap> get copyWith => __$KeybindingMapCopyWithImpl<_KeybindingMap>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KeybindingMapToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeybindingMap&&const DeepCollectionEquality().equals(other._keybindings, _keybindings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_keybindings));

@override
String toString() {
  return 'KeybindingMap(keybindings: $keybindings)';
}


}

/// @nodoc
abstract mixin class _$KeybindingMapCopyWith<$Res> implements $KeybindingMapCopyWith<$Res> {
  factory _$KeybindingMapCopyWith(_KeybindingMap value, $Res Function(_KeybindingMap) _then) = __$KeybindingMapCopyWithImpl;
@override @useResult
$Res call({
 List<(KeybindingAction, Keybinding)> keybindings
});




}
/// @nodoc
class __$KeybindingMapCopyWithImpl<$Res>
    implements _$KeybindingMapCopyWith<$Res> {
  __$KeybindingMapCopyWithImpl(this._self, this._then);

  final _KeybindingMap _self;
  final $Res Function(_KeybindingMap) _then;

/// Create a copy of KeybindingMap
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keybindings = null,}) {
  return _then(_KeybindingMap(
keybindings: null == keybindings ? _self._keybindings : keybindings // ignore: cast_nullable_to_non_nullable
as List<(KeybindingAction, Keybinding)>,
  ));
}


}

// dart format on
