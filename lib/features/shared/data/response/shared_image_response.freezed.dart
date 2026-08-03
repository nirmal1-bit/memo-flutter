// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared_image_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SharedImageResponse {

 int get id;@JsonKey(name: 'connection_id') int get connectionId;@JsonKey(name: 'uploaded_by') int get uploadedBy;@JsonKey(name: 'image_url') String get imageUrl; String get description; String get category;@JsonKey(name: 'is_favorite') bool get isFavorite;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of SharedImageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedImageResponseCopyWith<SharedImageResponse> get copyWith => _$SharedImageResponseCopyWithImpl<SharedImageResponse>(this as SharedImageResponse, _$identity);

  /// Serializes this SharedImageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedImageResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,connectionId,uploadedBy,imageUrl,description,category,isFavorite,createdAt);

@override
String toString() {
  return 'SharedImageResponse(id: $id, connectionId: $connectionId, uploadedBy: $uploadedBy, imageUrl: $imageUrl, description: $description, category: $category, isFavorite: $isFavorite, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SharedImageResponseCopyWith<$Res>  {
  factory $SharedImageResponseCopyWith(SharedImageResponse value, $Res Function(SharedImageResponse) _then) = _$SharedImageResponseCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'connection_id') int connectionId,@JsonKey(name: 'uploaded_by') int uploadedBy,@JsonKey(name: 'image_url') String imageUrl, String description, String category,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$SharedImageResponseCopyWithImpl<$Res>
    implements $SharedImageResponseCopyWith<$Res> {
  _$SharedImageResponseCopyWithImpl(this._self, this._then);

  final SharedImageResponse _self;
  final $Res Function(SharedImageResponse) _then;

/// Create a copy of SharedImageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? connectionId = null,Object? uploadedBy = null,Object? imageUrl = null,Object? description = null,Object? category = null,Object? isFavorite = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as int,uploadedBy: null == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SharedImageResponse].
extension SharedImageResponsePatterns on SharedImageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharedImageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharedImageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharedImageResponse value)  $default,){
final _that = this;
switch (_that) {
case _SharedImageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharedImageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SharedImageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'connection_id')  int connectionId, @JsonKey(name: 'uploaded_by')  int uploadedBy, @JsonKey(name: 'image_url')  String imageUrl,  String description,  String category, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharedImageResponse() when $default != null:
return $default(_that.id,_that.connectionId,_that.uploadedBy,_that.imageUrl,_that.description,_that.category,_that.isFavorite,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'connection_id')  int connectionId, @JsonKey(name: 'uploaded_by')  int uploadedBy, @JsonKey(name: 'image_url')  String imageUrl,  String description,  String category, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _SharedImageResponse():
return $default(_that.id,_that.connectionId,_that.uploadedBy,_that.imageUrl,_that.description,_that.category,_that.isFavorite,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'connection_id')  int connectionId, @JsonKey(name: 'uploaded_by')  int uploadedBy, @JsonKey(name: 'image_url')  String imageUrl,  String description,  String category, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SharedImageResponse() when $default != null:
return $default(_that.id,_that.connectionId,_that.uploadedBy,_that.imageUrl,_that.description,_that.category,_that.isFavorite,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SharedImageResponse implements SharedImageResponse {
  const _SharedImageResponse({required this.id, @JsonKey(name: 'connection_id') required this.connectionId, @JsonKey(name: 'uploaded_by') required this.uploadedBy, @JsonKey(name: 'image_url') required this.imageUrl, this.description = '', this.category = 'other', @JsonKey(name: 'is_favorite') this.isFavorite = false, @JsonKey(name: 'created_at') required this.createdAt});
  factory _SharedImageResponse.fromJson(Map<String, dynamic> json) => _$SharedImageResponseFromJson(json);

@override final  int id;
@override@JsonKey(name: 'connection_id') final  int connectionId;
@override@JsonKey(name: 'uploaded_by') final  int uploadedBy;
@override@JsonKey(name: 'image_url') final  String imageUrl;
@override@JsonKey() final  String description;
@override@JsonKey() final  String category;
@override@JsonKey(name: 'is_favorite') final  bool isFavorite;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of SharedImageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharedImageResponseCopyWith<_SharedImageResponse> get copyWith => __$SharedImageResponseCopyWithImpl<_SharedImageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SharedImageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharedImageResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,connectionId,uploadedBy,imageUrl,description,category,isFavorite,createdAt);

@override
String toString() {
  return 'SharedImageResponse(id: $id, connectionId: $connectionId, uploadedBy: $uploadedBy, imageUrl: $imageUrl, description: $description, category: $category, isFavorite: $isFavorite, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SharedImageResponseCopyWith<$Res> implements $SharedImageResponseCopyWith<$Res> {
  factory _$SharedImageResponseCopyWith(_SharedImageResponse value, $Res Function(_SharedImageResponse) _then) = __$SharedImageResponseCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'connection_id') int connectionId,@JsonKey(name: 'uploaded_by') int uploadedBy,@JsonKey(name: 'image_url') String imageUrl, String description, String category,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$SharedImageResponseCopyWithImpl<$Res>
    implements _$SharedImageResponseCopyWith<$Res> {
  __$SharedImageResponseCopyWithImpl(this._self, this._then);

  final _SharedImageResponse _self;
  final $Res Function(_SharedImageResponse) _then;

/// Create a copy of SharedImageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? connectionId = null,Object? uploadedBy = null,Object? imageUrl = null,Object? description = null,Object? category = null,Object? isFavorite = null,Object? createdAt = null,}) {
  return _then(_SharedImageResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as int,uploadedBy: null == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
