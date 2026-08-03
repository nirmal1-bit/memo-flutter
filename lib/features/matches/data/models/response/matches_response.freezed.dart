// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matches_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchesResponse {

 int get id; String get name;@JsonKey(name: 'user_id') int get userId; String get headline; String get bio;@JsonKey(name: 'profile_url') String get profileUrl; String get location; int get age; String get gender; List<String> get interests;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt; double get similarity; double get distance;
/// Create a copy of MatchesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchesResponseCopyWith<MatchesResponse> get copyWith => _$MatchesResponseCopyWithImpl<MatchesResponse>(this as MatchesResponse, _$identity);

  /// Serializes this MatchesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchesResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.profileUrl, profileUrl) || other.profileUrl == profileUrl)&&(identical(other.location, location) || other.location == location)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&const DeepCollectionEquality().equals(other.interests, interests)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.similarity, similarity) || other.similarity == similarity)&&(identical(other.distance, distance) || other.distance == distance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,userId,headline,bio,profileUrl,location,age,gender,const DeepCollectionEquality().hash(interests),createdAt,updatedAt,similarity,distance);

@override
String toString() {
  return 'MatchesResponse(id: $id, name: $name, userId: $userId, headline: $headline, bio: $bio, profileUrl: $profileUrl, location: $location, age: $age, gender: $gender, interests: $interests, createdAt: $createdAt, updatedAt: $updatedAt, similarity: $similarity, distance: $distance)';
}


}

/// @nodoc
abstract mixin class $MatchesResponseCopyWith<$Res>  {
  factory $MatchesResponseCopyWith(MatchesResponse value, $Res Function(MatchesResponse) _then) = _$MatchesResponseCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'user_id') int userId, String headline, String bio,@JsonKey(name: 'profile_url') String profileUrl, String location, int age, String gender, List<String> interests,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, double similarity, double distance
});




}
/// @nodoc
class _$MatchesResponseCopyWithImpl<$Res>
    implements $MatchesResponseCopyWith<$Res> {
  _$MatchesResponseCopyWithImpl(this._self, this._then);

  final MatchesResponse _self;
  final $Res Function(MatchesResponse) _then;

/// Create a copy of MatchesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? userId = null,Object? headline = null,Object? bio = null,Object? profileUrl = null,Object? location = null,Object? age = null,Object? gender = null,Object? interests = null,Object? createdAt = null,Object? updatedAt = null,Object? similarity = null,Object? distance = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,profileUrl: null == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchesResponse].
extension MatchesResponsePatterns on MatchesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchesResponse value)  $default,){
final _that = this;
switch (_that) {
case _MatchesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MatchesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'user_id')  int userId,  String headline,  String bio, @JsonKey(name: 'profile_url')  String profileUrl,  String location,  int age,  String gender,  List<String> interests, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  double similarity,  double distance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchesResponse() when $default != null:
return $default(_that.id,_that.name,_that.userId,_that.headline,_that.bio,_that.profileUrl,_that.location,_that.age,_that.gender,_that.interests,_that.createdAt,_that.updatedAt,_that.similarity,_that.distance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'user_id')  int userId,  String headline,  String bio, @JsonKey(name: 'profile_url')  String profileUrl,  String location,  int age,  String gender,  List<String> interests, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  double similarity,  double distance)  $default,) {final _that = this;
switch (_that) {
case _MatchesResponse():
return $default(_that.id,_that.name,_that.userId,_that.headline,_that.bio,_that.profileUrl,_that.location,_that.age,_that.gender,_that.interests,_that.createdAt,_that.updatedAt,_that.similarity,_that.distance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'user_id')  int userId,  String headline,  String bio, @JsonKey(name: 'profile_url')  String profileUrl,  String location,  int age,  String gender,  List<String> interests, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  double similarity,  double distance)?  $default,) {final _that = this;
switch (_that) {
case _MatchesResponse() when $default != null:
return $default(_that.id,_that.name,_that.userId,_that.headline,_that.bio,_that.profileUrl,_that.location,_that.age,_that.gender,_that.interests,_that.createdAt,_that.updatedAt,_that.similarity,_that.distance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchesResponse implements MatchesResponse {
  const _MatchesResponse({required this.id, required this.name, @JsonKey(name: 'user_id') required this.userId, required this.headline, required this.bio, @JsonKey(name: 'profile_url') required this.profileUrl, required this.location, required this.age, required this.gender, required final  List<String> interests, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, required this.similarity, required this.distance}): _interests = interests;
  factory _MatchesResponse.fromJson(Map<String, dynamic> json) => _$MatchesResponseFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(name: 'user_id') final  int userId;
@override final  String headline;
@override final  String bio;
@override@JsonKey(name: 'profile_url') final  String profileUrl;
@override final  String location;
@override final  int age;
@override final  String gender;
 final  List<String> _interests;
@override List<String> get interests {
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interests);
}

@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override final  double similarity;
@override final  double distance;

/// Create a copy of MatchesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchesResponseCopyWith<_MatchesResponse> get copyWith => __$MatchesResponseCopyWithImpl<_MatchesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchesResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.profileUrl, profileUrl) || other.profileUrl == profileUrl)&&(identical(other.location, location) || other.location == location)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&const DeepCollectionEquality().equals(other._interests, _interests)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.similarity, similarity) || other.similarity == similarity)&&(identical(other.distance, distance) || other.distance == distance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,userId,headline,bio,profileUrl,location,age,gender,const DeepCollectionEquality().hash(_interests),createdAt,updatedAt,similarity,distance);

@override
String toString() {
  return 'MatchesResponse(id: $id, name: $name, userId: $userId, headline: $headline, bio: $bio, profileUrl: $profileUrl, location: $location, age: $age, gender: $gender, interests: $interests, createdAt: $createdAt, updatedAt: $updatedAt, similarity: $similarity, distance: $distance)';
}


}

/// @nodoc
abstract mixin class _$MatchesResponseCopyWith<$Res> implements $MatchesResponseCopyWith<$Res> {
  factory _$MatchesResponseCopyWith(_MatchesResponse value, $Res Function(_MatchesResponse) _then) = __$MatchesResponseCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'user_id') int userId, String headline, String bio,@JsonKey(name: 'profile_url') String profileUrl, String location, int age, String gender, List<String> interests,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, double similarity, double distance
});




}
/// @nodoc
class __$MatchesResponseCopyWithImpl<$Res>
    implements _$MatchesResponseCopyWith<$Res> {
  __$MatchesResponseCopyWithImpl(this._self, this._then);

  final _MatchesResponse _self;
  final $Res Function(_MatchesResponse) _then;

/// Create a copy of MatchesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? userId = null,Object? headline = null,Object? bio = null,Object? profileUrl = null,Object? location = null,Object? age = null,Object? gender = null,Object? interests = null,Object? createdAt = null,Object? updatedAt = null,Object? similarity = null,Object? distance = null,}) {
  return _then(_MatchesResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,profileUrl: null == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
