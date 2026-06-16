// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectionResponse {

 int get id;@JsonKey(name: 'user_profile') UserProfile get userProfile;
/// Create a copy of ConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectionResponseCopyWith<ConnectionResponse> get copyWith => _$ConnectionResponseCopyWithImpl<ConnectionResponse>(this as ConnectionResponse, _$identity);

  /// Serializes this ConnectionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userProfile);

@override
String toString() {
  return 'ConnectionResponse(id: $id, userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class $ConnectionResponseCopyWith<$Res>  {
  factory $ConnectionResponseCopyWith(ConnectionResponse value, $Res Function(ConnectionResponse) _then) = _$ConnectionResponseCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'user_profile') UserProfile userProfile
});


$UserProfileCopyWith<$Res> get userProfile;

}
/// @nodoc
class _$ConnectionResponseCopyWithImpl<$Res>
    implements $ConnectionResponseCopyWith<$Res> {
  _$ConnectionResponseCopyWithImpl(this._self, this._then);

  final ConnectionResponse _self;
  final $Res Function(ConnectionResponse) _then;

/// Create a copy of ConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userProfile = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userProfile: null == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfile,
  ));
}
/// Create a copy of ConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res> get userProfile {
  
  return $UserProfileCopyWith<$Res>(_self.userProfile, (value) {
    return _then(_self.copyWith(userProfile: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConnectionResponse].
extension ConnectionResponsePatterns on ConnectionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectionResponse value)  $default,){
final _that = this;
switch (_that) {
case _ConnectionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_profile')  UserProfile userProfile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectionResponse() when $default != null:
return $default(_that.id,_that.userProfile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_profile')  UserProfile userProfile)  $default,) {final _that = this;
switch (_that) {
case _ConnectionResponse():
return $default(_that.id,_that.userProfile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'user_profile')  UserProfile userProfile)?  $default,) {final _that = this;
switch (_that) {
case _ConnectionResponse() when $default != null:
return $default(_that.id,_that.userProfile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectionResponse implements ConnectionResponse {
  const _ConnectionResponse({required this.id, @JsonKey(name: 'user_profile') required this.userProfile});
  factory _ConnectionResponse.fromJson(Map<String, dynamic> json) => _$ConnectionResponseFromJson(json);

@override final  int id;
@override@JsonKey(name: 'user_profile') final  UserProfile userProfile;

/// Create a copy of ConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionResponseCopyWith<_ConnectionResponse> get copyWith => __$ConnectionResponseCopyWithImpl<_ConnectionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConnectionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userProfile);

@override
String toString() {
  return 'ConnectionResponse(id: $id, userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class _$ConnectionResponseCopyWith<$Res> implements $ConnectionResponseCopyWith<$Res> {
  factory _$ConnectionResponseCopyWith(_ConnectionResponse value, $Res Function(_ConnectionResponse) _then) = __$ConnectionResponseCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'user_profile') UserProfile userProfile
});


@override $UserProfileCopyWith<$Res> get userProfile;

}
/// @nodoc
class __$ConnectionResponseCopyWithImpl<$Res>
    implements _$ConnectionResponseCopyWith<$Res> {
  __$ConnectionResponseCopyWithImpl(this._self, this._then);

  final _ConnectionResponse _self;
  final $Res Function(_ConnectionResponse) _then;

/// Create a copy of ConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userProfile = null,}) {
  return _then(_ConnectionResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userProfile: null == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfile,
  ));
}

/// Create a copy of ConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res> get userProfile {
  
  return $UserProfileCopyWith<$Res>(_self.userProfile, (value) {
    return _then(_self.copyWith(userProfile: value));
  });
}
}


/// @nodoc
mixin _$UserProfile {

 int get id;@JsonKey(name: 'user_id') int get userId; String get name; String get headline; String get bio;@JsonKey(name: 'profile_url') String get profileUrl; String get location; int get age; String get gender; List<String> get interests;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.profileUrl, profileUrl) || other.profileUrl == profileUrl)&&(identical(other.location, location) || other.location == location)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&const DeepCollectionEquality().equals(other.interests, interests)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,headline,bio,profileUrl,location,age,gender,const DeepCollectionEquality().hash(interests),createdAt,updatedAt);

@override
String toString() {
  return 'UserProfile(id: $id, userId: $userId, name: $name, headline: $headline, bio: $bio, profileUrl: $profileUrl, location: $location, age: $age, gender: $gender, interests: $interests, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'user_id') int userId, String name, String headline, String bio,@JsonKey(name: 'profile_url') String profileUrl, String location, int age, String gender, List<String> interests,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? headline = null,Object? bio = null,Object? profileUrl = null,Object? location = null,Object? age = null,Object? gender = null,Object? interests = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,profileUrl: null == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_id')  int userId,  String name,  String headline,  String bio, @JsonKey(name: 'profile_url')  String profileUrl,  String location,  int age,  String gender,  List<String> interests, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.headline,_that.bio,_that.profileUrl,_that.location,_that.age,_that.gender,_that.interests,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_id')  int userId,  String name,  String headline,  String bio, @JsonKey(name: 'profile_url')  String profileUrl,  String location,  int age,  String gender,  List<String> interests, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.userId,_that.name,_that.headline,_that.bio,_that.profileUrl,_that.location,_that.age,_that.gender,_that.interests,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'user_id')  int userId,  String name,  String headline,  String bio, @JsonKey(name: 'profile_url')  String profileUrl,  String location,  int age,  String gender,  List<String> interests, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.headline,_that.bio,_that.profileUrl,_that.location,_that.age,_that.gender,_that.interests,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.name, required this.headline, required this.bio, @JsonKey(name: 'profile_url') required this.profileUrl, required this.location, required this.age, required this.gender, required final  List<String> interests, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): _interests = interests;
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  int id;
@override@JsonKey(name: 'user_id') final  int userId;
@override final  String name;
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

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.profileUrl, profileUrl) || other.profileUrl == profileUrl)&&(identical(other.location, location) || other.location == location)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&const DeepCollectionEquality().equals(other._interests, _interests)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,headline,bio,profileUrl,location,age,gender,const DeepCollectionEquality().hash(_interests),createdAt,updatedAt);

@override
String toString() {
  return 'UserProfile(id: $id, userId: $userId, name: $name, headline: $headline, bio: $bio, profileUrl: $profileUrl, location: $location, age: $age, gender: $gender, interests: $interests, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'user_id') int userId, String name, String headline, String bio,@JsonKey(name: 'profile_url') String profileUrl, String location, int age, String gender, List<String> interests,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? headline = null,Object? bio = null,Object? profileUrl = null,Object? location = null,Object? age = null,Object? gender = null,Object? interests = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,profileUrl: null == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
