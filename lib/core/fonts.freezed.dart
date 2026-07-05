// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fonts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TiefPromptFontsVariant {

 int get weight; FontStyle get fontStyle; Future<ByteData> Function() get load; String? get originalFileName; bool get isVariable; (int, int)? get weightRange;
/// Create a copy of TiefPromptFontsVariant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TiefPromptFontsVariantCopyWith<TiefPromptFontsVariant> get copyWith => _$TiefPromptFontsVariantCopyWithImpl<TiefPromptFontsVariant>(this as TiefPromptFontsVariant, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TiefPromptFontsVariant&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.fontStyle, fontStyle) || other.fontStyle == fontStyle)&&(identical(other.load, load) || other.load == load)&&(identical(other.originalFileName, originalFileName) || other.originalFileName == originalFileName)&&(identical(other.isVariable, isVariable) || other.isVariable == isVariable)&&(identical(other.weightRange, weightRange) || other.weightRange == weightRange));
}


@override
int get hashCode => Object.hash(runtimeType,weight,fontStyle,load,originalFileName,isVariable,weightRange);

@override
String toString() {
  return 'TiefPromptFontsVariant(weight: $weight, fontStyle: $fontStyle, load: $load, originalFileName: $originalFileName, isVariable: $isVariable, weightRange: $weightRange)';
}


}

/// @nodoc
abstract mixin class $TiefPromptFontsVariantCopyWith<$Res>  {
  factory $TiefPromptFontsVariantCopyWith(TiefPromptFontsVariant value, $Res Function(TiefPromptFontsVariant) _then) = _$TiefPromptFontsVariantCopyWithImpl;
@useResult
$Res call({
 int weight, FontStyle fontStyle, Future<ByteData> Function() load, String? originalFileName, bool isVariable, (int, int)? weightRange
});




}
/// @nodoc
class _$TiefPromptFontsVariantCopyWithImpl<$Res>
    implements $TiefPromptFontsVariantCopyWith<$Res> {
  _$TiefPromptFontsVariantCopyWithImpl(this._self, this._then);

  final TiefPromptFontsVariant _self;
  final $Res Function(TiefPromptFontsVariant) _then;

/// Create a copy of TiefPromptFontsVariant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weight = null,Object? fontStyle = null,Object? load = null,Object? originalFileName = freezed,Object? isVariable = null,Object? weightRange = freezed,}) {
  return _then(_self.copyWith(
weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,fontStyle: null == fontStyle ? _self.fontStyle : fontStyle // ignore: cast_nullable_to_non_nullable
as FontStyle,load: null == load ? _self.load : load // ignore: cast_nullable_to_non_nullable
as Future<ByteData> Function(),originalFileName: freezed == originalFileName ? _self.originalFileName : originalFileName // ignore: cast_nullable_to_non_nullable
as String?,isVariable: null == isVariable ? _self.isVariable : isVariable // ignore: cast_nullable_to_non_nullable
as bool,weightRange: freezed == weightRange ? _self.weightRange : weightRange // ignore: cast_nullable_to_non_nullable
as (int, int)?,
  ));
}

}


/// Adds pattern-matching-related methods to [TiefPromptFontsVariant].
extension TiefPromptFontsVariantPatterns on TiefPromptFontsVariant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TiefPromptFontsVariant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TiefPromptFontsVariant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TiefPromptFontsVariant value)  $default,){
final _that = this;
switch (_that) {
case _TiefPromptFontsVariant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TiefPromptFontsVariant value)?  $default,){
final _that = this;
switch (_that) {
case _TiefPromptFontsVariant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int weight,  FontStyle fontStyle,  Future<ByteData> Function() load,  String? originalFileName,  bool isVariable,  (int, int)? weightRange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TiefPromptFontsVariant() when $default != null:
return $default(_that.weight,_that.fontStyle,_that.load,_that.originalFileName,_that.isVariable,_that.weightRange);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int weight,  FontStyle fontStyle,  Future<ByteData> Function() load,  String? originalFileName,  bool isVariable,  (int, int)? weightRange)  $default,) {final _that = this;
switch (_that) {
case _TiefPromptFontsVariant():
return $default(_that.weight,_that.fontStyle,_that.load,_that.originalFileName,_that.isVariable,_that.weightRange);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int weight,  FontStyle fontStyle,  Future<ByteData> Function() load,  String? originalFileName,  bool isVariable,  (int, int)? weightRange)?  $default,) {final _that = this;
switch (_that) {
case _TiefPromptFontsVariant() when $default != null:
return $default(_that.weight,_that.fontStyle,_that.load,_that.originalFileName,_that.isVariable,_that.weightRange);case _:
  return null;

}
}

}

/// @nodoc


class _TiefPromptFontsVariant implements TiefPromptFontsVariant {
   _TiefPromptFontsVariant({required this.weight, required this.fontStyle, required this.load, this.originalFileName, this.isVariable = false, this.weightRange = null});
  

@override final  int weight;
@override final  FontStyle fontStyle;
@override final  Future<ByteData> Function() load;
@override final  String? originalFileName;
@override@JsonKey() final  bool isVariable;
@override@JsonKey() final  (int, int)? weightRange;

/// Create a copy of TiefPromptFontsVariant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TiefPromptFontsVariantCopyWith<_TiefPromptFontsVariant> get copyWith => __$TiefPromptFontsVariantCopyWithImpl<_TiefPromptFontsVariant>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TiefPromptFontsVariant&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.fontStyle, fontStyle) || other.fontStyle == fontStyle)&&(identical(other.load, load) || other.load == load)&&(identical(other.originalFileName, originalFileName) || other.originalFileName == originalFileName)&&(identical(other.isVariable, isVariable) || other.isVariable == isVariable)&&(identical(other.weightRange, weightRange) || other.weightRange == weightRange));
}


@override
int get hashCode => Object.hash(runtimeType,weight,fontStyle,load,originalFileName,isVariable,weightRange);

@override
String toString() {
  return 'TiefPromptFontsVariant(weight: $weight, fontStyle: $fontStyle, load: $load, originalFileName: $originalFileName, isVariable: $isVariable, weightRange: $weightRange)';
}


}

/// @nodoc
abstract mixin class _$TiefPromptFontsVariantCopyWith<$Res> implements $TiefPromptFontsVariantCopyWith<$Res> {
  factory _$TiefPromptFontsVariantCopyWith(_TiefPromptFontsVariant value, $Res Function(_TiefPromptFontsVariant) _then) = __$TiefPromptFontsVariantCopyWithImpl;
@override @useResult
$Res call({
 int weight, FontStyle fontStyle, Future<ByteData> Function() load, String? originalFileName, bool isVariable, (int, int)? weightRange
});




}
/// @nodoc
class __$TiefPromptFontsVariantCopyWithImpl<$Res>
    implements _$TiefPromptFontsVariantCopyWith<$Res> {
  __$TiefPromptFontsVariantCopyWithImpl(this._self, this._then);

  final _TiefPromptFontsVariant _self;
  final $Res Function(_TiefPromptFontsVariant) _then;

/// Create a copy of TiefPromptFontsVariant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weight = null,Object? fontStyle = null,Object? load = null,Object? originalFileName = freezed,Object? isVariable = null,Object? weightRange = freezed,}) {
  return _then(_TiefPromptFontsVariant(
weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,fontStyle: null == fontStyle ? _self.fontStyle : fontStyle // ignore: cast_nullable_to_non_nullable
as FontStyle,load: null == load ? _self.load : load // ignore: cast_nullable_to_non_nullable
as Future<ByteData> Function(),originalFileName: freezed == originalFileName ? _self.originalFileName : originalFileName // ignore: cast_nullable_to_non_nullable
as String?,isVariable: null == isVariable ? _self.isVariable : isVariable // ignore: cast_nullable_to_non_nullable
as bool,weightRange: freezed == weightRange ? _self.weightRange : weightRange // ignore: cast_nullable_to_non_nullable
as (int, int)?,
  ));
}


}

/// @nodoc
mixin _$TiefPromptFontsFile {

 String get name; List<TiefPromptFontsVariant> get variants; bool get isBuiltIn;
/// Create a copy of TiefPromptFontsFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TiefPromptFontsFileCopyWith<TiefPromptFontsFile> get copyWith => _$TiefPromptFontsFileCopyWithImpl<TiefPromptFontsFile>(this as TiefPromptFontsFile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TiefPromptFontsFile&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.variants, variants)&&(identical(other.isBuiltIn, isBuiltIn) || other.isBuiltIn == isBuiltIn));
}


@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(variants),isBuiltIn);

@override
String toString() {
  return 'TiefPromptFontsFile(name: $name, variants: $variants, isBuiltIn: $isBuiltIn)';
}


}

/// @nodoc
abstract mixin class $TiefPromptFontsFileCopyWith<$Res>  {
  factory $TiefPromptFontsFileCopyWith(TiefPromptFontsFile value, $Res Function(TiefPromptFontsFile) _then) = _$TiefPromptFontsFileCopyWithImpl;
@useResult
$Res call({
 String name, List<TiefPromptFontsVariant> variants, bool isBuiltIn
});




}
/// @nodoc
class _$TiefPromptFontsFileCopyWithImpl<$Res>
    implements $TiefPromptFontsFileCopyWith<$Res> {
  _$TiefPromptFontsFileCopyWithImpl(this._self, this._then);

  final TiefPromptFontsFile _self;
  final $Res Function(TiefPromptFontsFile) _then;

/// Create a copy of TiefPromptFontsFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? variants = null,Object? isBuiltIn = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,variants: null == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<TiefPromptFontsVariant>,isBuiltIn: null == isBuiltIn ? _self.isBuiltIn : isBuiltIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TiefPromptFontsFile].
extension TiefPromptFontsFilePatterns on TiefPromptFontsFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TiefPromptFontsFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TiefPromptFontsFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TiefPromptFontsFile value)  $default,){
final _that = this;
switch (_that) {
case _TiefPromptFontsFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TiefPromptFontsFile value)?  $default,){
final _that = this;
switch (_that) {
case _TiefPromptFontsFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  List<TiefPromptFontsVariant> variants,  bool isBuiltIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TiefPromptFontsFile() when $default != null:
return $default(_that.name,_that.variants,_that.isBuiltIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  List<TiefPromptFontsVariant> variants,  bool isBuiltIn)  $default,) {final _that = this;
switch (_that) {
case _TiefPromptFontsFile():
return $default(_that.name,_that.variants,_that.isBuiltIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  List<TiefPromptFontsVariant> variants,  bool isBuiltIn)?  $default,) {final _that = this;
switch (_that) {
case _TiefPromptFontsFile() when $default != null:
return $default(_that.name,_that.variants,_that.isBuiltIn);case _:
  return null;

}
}

}

/// @nodoc


class _TiefPromptFontsFile implements TiefPromptFontsFile {
   _TiefPromptFontsFile({required this.name, required final  List<TiefPromptFontsVariant> variants, this.isBuiltIn = false}): _variants = variants;
  

@override final  String name;
 final  List<TiefPromptFontsVariant> _variants;
@override List<TiefPromptFontsVariant> get variants {
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_variants);
}

@override@JsonKey() final  bool isBuiltIn;

/// Create a copy of TiefPromptFontsFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TiefPromptFontsFileCopyWith<_TiefPromptFontsFile> get copyWith => __$TiefPromptFontsFileCopyWithImpl<_TiefPromptFontsFile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TiefPromptFontsFile&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._variants, _variants)&&(identical(other.isBuiltIn, isBuiltIn) || other.isBuiltIn == isBuiltIn));
}


@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_variants),isBuiltIn);

@override
String toString() {
  return 'TiefPromptFontsFile(name: $name, variants: $variants, isBuiltIn: $isBuiltIn)';
}


}

/// @nodoc
abstract mixin class _$TiefPromptFontsFileCopyWith<$Res> implements $TiefPromptFontsFileCopyWith<$Res> {
  factory _$TiefPromptFontsFileCopyWith(_TiefPromptFontsFile value, $Res Function(_TiefPromptFontsFile) _then) = __$TiefPromptFontsFileCopyWithImpl;
@override @useResult
$Res call({
 String name, List<TiefPromptFontsVariant> variants, bool isBuiltIn
});




}
/// @nodoc
class __$TiefPromptFontsFileCopyWithImpl<$Res>
    implements _$TiefPromptFontsFileCopyWith<$Res> {
  __$TiefPromptFontsFileCopyWithImpl(this._self, this._then);

  final _TiefPromptFontsFile _self;
  final $Res Function(_TiefPromptFontsFile) _then;

/// Create a copy of TiefPromptFontsFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? variants = null,Object? isBuiltIn = null,}) {
  return _then(_TiefPromptFontsFile(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,variants: null == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<TiefPromptFontsVariant>,isBuiltIn: null == isBuiltIn ? _self.isBuiltIn : isBuiltIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
