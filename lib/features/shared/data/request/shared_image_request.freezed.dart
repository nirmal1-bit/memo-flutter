// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared_image_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SharedImageRequest {

@JsonKey(name: 'image_url') String get imageUrl; String get description; String get category;
/// Create a copy of SharedImageRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedImageRequestCopyWith<SharedImageRequest> get copyWith => _$SharedImageRequestCopyWithImpl<SharedImageRequest>(this as SharedImageRequest, _$identity);

  /// Serializes this SharedImageRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedImageRequest&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,description,category);

@override
String toString() {
  return 'SharedImageRequest(imageUrl: $imageUrl, description: $description, category: $category)';
}


}

/// @nodoc
abstract mixin class $SharedImageRequestCopyWith<$Res>  {
  factory $SharedImageRequestCopyWith(SharedImageRequest value, $Res Function(SharedImageRequest) _then) = _$SharedImageRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'image_url') String imageUrl, String description, String category
});




}
/// @nodoc
class _$SharedImageRequestCopyWithImpl<$Res>
    implements $SharedImageRequestCopyWith<$Res> {
  _$SharedImageRequestCopyWithImpl(this._self, this._then);

  final SharedImageRequest _self;
  final $Res Function(SharedImageRequest) _then;

/// Create a copy of SharedImageRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = null,Object? description = null,Object? category = null,}) {
  return _then(_self.copyWith(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SharedImageRequest].
extension SharedImageRequestPatterns on SharedImageRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharedImageRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharedImageRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharedImageRequest value)  $default,){
final _that = this;
switch (_that) {
case _SharedImageRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharedImageRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SharedImageRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'image_url')  String imageUrl,  String description,  String category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharedImageRequest() when $default != null:
return $default(_that.imageUrl,_that.description,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'image_url')  String imageUrl,  String description,  String category)  $default,) {final _that = this;
switch (_that) {
case _SharedImageRequest():
return $default(_that.imageUrl,_that.description,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'image_url')  String imageUrl,  String description,  String category)?  $default,) {final _that = this;
switch (_that) {
case _SharedImageRequest() when $default != null:
return $default(_that.imageUrl,_that.description,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SharedImageRequest implements SharedImageRequest {
  const _SharedImageRequest({@JsonKey(name: 'image_url') required this.imageUrl, required this.description, required this.category});
  factory _SharedImageRequest.fromJson(Map<String, dynamic> json) => _$SharedImageRequestFromJson(json);

@override@JsonKey(name: 'image_url') final  String imageUrl;
@override final  String description;
@override final  String category;

/// Create a copy of SharedImageRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharedImageRequestCopyWith<_SharedImageRequest> get copyWith => __$SharedImageRequestCopyWithImpl<_SharedImageRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SharedImageRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharedImageRequest&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,description,category);

@override
String toString() {
  return 'SharedImageRequest(imageUrl: $imageUrl, description: $description, category: $category)';
}


}

/// @nodoc
abstract mixin class _$SharedImageRequestCopyWith<$Res> implements $SharedImageRequestCopyWith<$Res> {
  factory _$SharedImageRequestCopyWith(_SharedImageRequest value, $Res Function(_SharedImageRequest) _then) = __$SharedImageRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'image_url') String imageUrl, String description, String category
});




}
/// @nodoc
class __$SharedImageRequestCopyWithImpl<$Res>
    implements _$SharedImageRequestCopyWith<$Res> {
  __$SharedImageRequestCopyWithImpl(this._self, this._then);

  final _SharedImageRequest _self;
  final $Res Function(_SharedImageRequest) _then;

/// Create a copy of SharedImageRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = null,Object? description = null,Object? category = null,}) {
  return _then(_SharedImageRequest(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
