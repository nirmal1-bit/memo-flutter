// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bucket_item_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BucketItemResponse {

 int get id;@JsonKey(name: 'connection_id') int get connectionId;@JsonKey(name: 'created_by') int get createdBy; String get title; String get category; bool get completed;@JsonKey(name: 'completed_at') DateTime? get completedAt;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of BucketItemResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BucketItemResponseCopyWith<BucketItemResponse> get copyWith => _$BucketItemResponseCopyWithImpl<BucketItemResponse>(this as BucketItemResponse, _$identity);

  /// Serializes this BucketItemResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BucketItemResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,connectionId,createdBy,title,category,completed,completedAt,createdAt);

@override
String toString() {
  return 'BucketItemResponse(id: $id, connectionId: $connectionId, createdBy: $createdBy, title: $title, category: $category, completed: $completed, completedAt: $completedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BucketItemResponseCopyWith<$Res>  {
  factory $BucketItemResponseCopyWith(BucketItemResponse value, $Res Function(BucketItemResponse) _then) = _$BucketItemResponseCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'connection_id') int connectionId,@JsonKey(name: 'created_by') int createdBy, String title, String category, bool completed,@JsonKey(name: 'completed_at') DateTime? completedAt,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$BucketItemResponseCopyWithImpl<$Res>
    implements $BucketItemResponseCopyWith<$Res> {
  _$BucketItemResponseCopyWithImpl(this._self, this._then);

  final BucketItemResponse _self;
  final $Res Function(BucketItemResponse) _then;

/// Create a copy of BucketItemResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? connectionId = null,Object? createdBy = null,Object? title = null,Object? category = null,Object? completed = null,Object? completedAt = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BucketItemResponse].
extension BucketItemResponsePatterns on BucketItemResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BucketItemResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BucketItemResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BucketItemResponse value)  $default,){
final _that = this;
switch (_that) {
case _BucketItemResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BucketItemResponse value)?  $default,){
final _that = this;
switch (_that) {
case _BucketItemResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'connection_id')  int connectionId, @JsonKey(name: 'created_by')  int createdBy,  String title,  String category,  bool completed, @JsonKey(name: 'completed_at')  DateTime? completedAt, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BucketItemResponse() when $default != null:
return $default(_that.id,_that.connectionId,_that.createdBy,_that.title,_that.category,_that.completed,_that.completedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'connection_id')  int connectionId, @JsonKey(name: 'created_by')  int createdBy,  String title,  String category,  bool completed, @JsonKey(name: 'completed_at')  DateTime? completedAt, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _BucketItemResponse():
return $default(_that.id,_that.connectionId,_that.createdBy,_that.title,_that.category,_that.completed,_that.completedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'connection_id')  int connectionId, @JsonKey(name: 'created_by')  int createdBy,  String title,  String category,  bool completed, @JsonKey(name: 'completed_at')  DateTime? completedAt, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BucketItemResponse() when $default != null:
return $default(_that.id,_that.connectionId,_that.createdBy,_that.title,_that.category,_that.completed,_that.completedAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BucketItemResponse implements BucketItemResponse {
  const _BucketItemResponse({required this.id, @JsonKey(name: 'connection_id') required this.connectionId, @JsonKey(name: 'created_by') required this.createdBy, required this.title, this.category = 'other', this.completed = false, @JsonKey(name: 'completed_at') this.completedAt, @JsonKey(name: 'created_at') required this.createdAt});
  factory _BucketItemResponse.fromJson(Map<String, dynamic> json) => _$BucketItemResponseFromJson(json);

@override final  int id;
@override@JsonKey(name: 'connection_id') final  int connectionId;
@override@JsonKey(name: 'created_by') final  int createdBy;
@override final  String title;
@override@JsonKey() final  String category;
@override@JsonKey() final  bool completed;
@override@JsonKey(name: 'completed_at') final  DateTime? completedAt;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of BucketItemResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BucketItemResponseCopyWith<_BucketItemResponse> get copyWith => __$BucketItemResponseCopyWithImpl<_BucketItemResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BucketItemResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BucketItemResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,connectionId,createdBy,title,category,completed,completedAt,createdAt);

@override
String toString() {
  return 'BucketItemResponse(id: $id, connectionId: $connectionId, createdBy: $createdBy, title: $title, category: $category, completed: $completed, completedAt: $completedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BucketItemResponseCopyWith<$Res> implements $BucketItemResponseCopyWith<$Res> {
  factory _$BucketItemResponseCopyWith(_BucketItemResponse value, $Res Function(_BucketItemResponse) _then) = __$BucketItemResponseCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'connection_id') int connectionId,@JsonKey(name: 'created_by') int createdBy, String title, String category, bool completed,@JsonKey(name: 'completed_at') DateTime? completedAt,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$BucketItemResponseCopyWithImpl<$Res>
    implements _$BucketItemResponseCopyWith<$Res> {
  __$BucketItemResponseCopyWithImpl(this._self, this._then);

  final _BucketItemResponse _self;
  final $Res Function(_BucketItemResponse) _then;

/// Create a copy of BucketItemResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? connectionId = null,Object? createdBy = null,Object? title = null,Object? category = null,Object? completed = null,Object? completedAt = freezed,Object? createdAt = null,}) {
  return _then(_BucketItemResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
