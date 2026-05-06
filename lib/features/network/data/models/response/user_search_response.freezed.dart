// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSearchResponse {

 SearchUser get user; SearchProfile? get profile;
/// Create a copy of UserSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchResponseCopyWith<UserSearchResponse> get copyWith => _$UserSearchResponseCopyWithImpl<UserSearchResponse>(this as UserSearchResponse, _$identity);

  /// Serializes this UserSearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.profile, profile) || other.profile == profile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,profile);

@override
String toString() {
  return 'UserSearchResponse(user: $user, profile: $profile)';
}


}

/// @nodoc
abstract mixin class $UserSearchResponseCopyWith<$Res>  {
  factory $UserSearchResponseCopyWith(UserSearchResponse value, $Res Function(UserSearchResponse) _then) = _$UserSearchResponseCopyWithImpl;
@useResult
$Res call({
 SearchUser user, SearchProfile? profile
});


$SearchUserCopyWith<$Res> get user;$SearchProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class _$UserSearchResponseCopyWithImpl<$Res>
    implements $UserSearchResponseCopyWith<$Res> {
  _$UserSearchResponseCopyWithImpl(this._self, this._then);

  final UserSearchResponse _self;
  final $Res Function(UserSearchResponse) _then;

/// Create a copy of UserSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? profile = freezed,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as SearchUser,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as SearchProfile?,
  ));
}
/// Create a copy of UserSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchUserCopyWith<$Res> get user {
  
  return $SearchUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of UserSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $SearchProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserSearchResponse].
extension UserSearchResponsePatterns on UserSearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserSearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserSearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SearchUser user,  SearchProfile? profile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSearchResponse() when $default != null:
return $default(_that.user,_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SearchUser user,  SearchProfile? profile)  $default,) {final _that = this;
switch (_that) {
case _UserSearchResponse():
return $default(_that.user,_that.profile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SearchUser user,  SearchProfile? profile)?  $default,) {final _that = this;
switch (_that) {
case _UserSearchResponse() when $default != null:
return $default(_that.user,_that.profile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSearchResponse implements UserSearchResponse {
  const _UserSearchResponse({required this.user, this.profile});
  factory _UserSearchResponse.fromJson(Map<String, dynamic> json) => _$UserSearchResponseFromJson(json);

@override final  SearchUser user;
@override final  SearchProfile? profile;

/// Create a copy of UserSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchResponseCopyWith<_UserSearchResponse> get copyWith => __$UserSearchResponseCopyWithImpl<_UserSearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.profile, profile) || other.profile == profile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,profile);

@override
String toString() {
  return 'UserSearchResponse(user: $user, profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$UserSearchResponseCopyWith<$Res> implements $UserSearchResponseCopyWith<$Res> {
  factory _$UserSearchResponseCopyWith(_UserSearchResponse value, $Res Function(_UserSearchResponse) _then) = __$UserSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 SearchUser user, SearchProfile? profile
});


@override $SearchUserCopyWith<$Res> get user;@override $SearchProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class __$UserSearchResponseCopyWithImpl<$Res>
    implements _$UserSearchResponseCopyWith<$Res> {
  __$UserSearchResponseCopyWithImpl(this._self, this._then);

  final _UserSearchResponse _self;
  final $Res Function(_UserSearchResponse) _then;

/// Create a copy of UserSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? profile = freezed,}) {
  return _then(_UserSearchResponse(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as SearchUser,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as SearchProfile?,
  ));
}

/// Create a copy of UserSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchUserCopyWith<$Res> get user {
  
  return $SearchUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of UserSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $SearchProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// @nodoc
mixin _$SearchUser {

 int get id;@JsonKey(name: 'created_at') DateTime get createdAt; String get name; String get email; bool get activated; String get role;@JsonKey(name: 'trial_left') int get trialLeft;@JsonKey(name: 'is_premium') bool get isPremium;@JsonKey(name: 'revenue_id') String get revenueId;
/// Create a copy of SearchUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchUserCopyWith<SearchUser> get copyWith => _$SearchUserCopyWithImpl<SearchUser>(this as SearchUser, _$identity);

  /// Serializes this SearchUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchUser&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.activated, activated) || other.activated == activated)&&(identical(other.role, role) || other.role == role)&&(identical(other.trialLeft, trialLeft) || other.trialLeft == trialLeft)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.revenueId, revenueId) || other.revenueId == revenueId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,name,email,activated,role,trialLeft,isPremium,revenueId);

@override
String toString() {
  return 'SearchUser(id: $id, createdAt: $createdAt, name: $name, email: $email, activated: $activated, role: $role, trialLeft: $trialLeft, isPremium: $isPremium, revenueId: $revenueId)';
}


}

/// @nodoc
abstract mixin class $SearchUserCopyWith<$Res>  {
  factory $SearchUserCopyWith(SearchUser value, $Res Function(SearchUser) _then) = _$SearchUserCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'created_at') DateTime createdAt, String name, String email, bool activated, String role,@JsonKey(name: 'trial_left') int trialLeft,@JsonKey(name: 'is_premium') bool isPremium,@JsonKey(name: 'revenue_id') String revenueId
});




}
/// @nodoc
class _$SearchUserCopyWithImpl<$Res>
    implements $SearchUserCopyWith<$Res> {
  _$SearchUserCopyWithImpl(this._self, this._then);

  final SearchUser _self;
  final $Res Function(SearchUser) _then;

/// Create a copy of SearchUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? name = null,Object? email = null,Object? activated = null,Object? role = null,Object? trialLeft = null,Object? isPremium = null,Object? revenueId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,activated: null == activated ? _self.activated : activated // ignore: cast_nullable_to_non_nullable
as bool,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,trialLeft: null == trialLeft ? _self.trialLeft : trialLeft // ignore: cast_nullable_to_non_nullable
as int,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,revenueId: null == revenueId ? _self.revenueId : revenueId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchUser].
extension SearchUserPatterns on SearchUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchUser value)  $default,){
final _that = this;
switch (_that) {
case _SearchUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchUser value)?  $default,){
final _that = this;
switch (_that) {
case _SearchUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'created_at')  DateTime createdAt,  String name,  String email,  bool activated,  String role, @JsonKey(name: 'trial_left')  int trialLeft, @JsonKey(name: 'is_premium')  bool isPremium, @JsonKey(name: 'revenue_id')  String revenueId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchUser() when $default != null:
return $default(_that.id,_that.createdAt,_that.name,_that.email,_that.activated,_that.role,_that.trialLeft,_that.isPremium,_that.revenueId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'created_at')  DateTime createdAt,  String name,  String email,  bool activated,  String role, @JsonKey(name: 'trial_left')  int trialLeft, @JsonKey(name: 'is_premium')  bool isPremium, @JsonKey(name: 'revenue_id')  String revenueId)  $default,) {final _that = this;
switch (_that) {
case _SearchUser():
return $default(_that.id,_that.createdAt,_that.name,_that.email,_that.activated,_that.role,_that.trialLeft,_that.isPremium,_that.revenueId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'created_at')  DateTime createdAt,  String name,  String email,  bool activated,  String role, @JsonKey(name: 'trial_left')  int trialLeft, @JsonKey(name: 'is_premium')  bool isPremium, @JsonKey(name: 'revenue_id')  String revenueId)?  $default,) {final _that = this;
switch (_that) {
case _SearchUser() when $default != null:
return $default(_that.id,_that.createdAt,_that.name,_that.email,_that.activated,_that.role,_that.trialLeft,_that.isPremium,_that.revenueId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchUser implements SearchUser {
  const _SearchUser({required this.id, @JsonKey(name: 'created_at') required this.createdAt, required this.name, required this.email, required this.activated, required this.role, @JsonKey(name: 'trial_left') required this.trialLeft, @JsonKey(name: 'is_premium') required this.isPremium, @JsonKey(name: 'revenue_id') required this.revenueId});
  factory _SearchUser.fromJson(Map<String, dynamic> json) => _$SearchUserFromJson(json);

@override final  int id;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override final  String name;
@override final  String email;
@override final  bool activated;
@override final  String role;
@override@JsonKey(name: 'trial_left') final  int trialLeft;
@override@JsonKey(name: 'is_premium') final  bool isPremium;
@override@JsonKey(name: 'revenue_id') final  String revenueId;

/// Create a copy of SearchUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchUserCopyWith<_SearchUser> get copyWith => __$SearchUserCopyWithImpl<_SearchUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchUser&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.activated, activated) || other.activated == activated)&&(identical(other.role, role) || other.role == role)&&(identical(other.trialLeft, trialLeft) || other.trialLeft == trialLeft)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.revenueId, revenueId) || other.revenueId == revenueId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,name,email,activated,role,trialLeft,isPremium,revenueId);

@override
String toString() {
  return 'SearchUser(id: $id, createdAt: $createdAt, name: $name, email: $email, activated: $activated, role: $role, trialLeft: $trialLeft, isPremium: $isPremium, revenueId: $revenueId)';
}


}

/// @nodoc
abstract mixin class _$SearchUserCopyWith<$Res> implements $SearchUserCopyWith<$Res> {
  factory _$SearchUserCopyWith(_SearchUser value, $Res Function(_SearchUser) _then) = __$SearchUserCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'created_at') DateTime createdAt, String name, String email, bool activated, String role,@JsonKey(name: 'trial_left') int trialLeft,@JsonKey(name: 'is_premium') bool isPremium,@JsonKey(name: 'revenue_id') String revenueId
});




}
/// @nodoc
class __$SearchUserCopyWithImpl<$Res>
    implements _$SearchUserCopyWith<$Res> {
  __$SearchUserCopyWithImpl(this._self, this._then);

  final _SearchUser _self;
  final $Res Function(_SearchUser) _then;

/// Create a copy of SearchUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? name = null,Object? email = null,Object? activated = null,Object? role = null,Object? trialLeft = null,Object? isPremium = null,Object? revenueId = null,}) {
  return _then(_SearchUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,activated: null == activated ? _self.activated : activated // ignore: cast_nullable_to_non_nullable
as bool,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,trialLeft: null == trialLeft ? _self.trialLeft : trialLeft // ignore: cast_nullable_to_non_nullable
as int,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,revenueId: null == revenueId ? _self.revenueId : revenueId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SearchProfile {

 int get id;@JsonKey(name: 'user_id') int get userId; String get headline; String get bio;@JsonKey(name: 'profile_url') String get profileUrl;@JsonKey(name: 'avatar_url') String get avatarUrl; String get website; String get location;@JsonKey(name: 'company_name') String get companyName;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of SearchProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchProfileCopyWith<SearchProfile> get copyWith => _$SearchProfileCopyWithImpl<SearchProfile>(this as SearchProfile, _$identity);

  /// Serializes this SearchProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.profileUrl, profileUrl) || other.profileUrl == profileUrl)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.website, website) || other.website == website)&&(identical(other.location, location) || other.location == location)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,headline,bio,profileUrl,avatarUrl,website,location,companyName,createdAt,updatedAt);

@override
String toString() {
  return 'SearchProfile(id: $id, userId: $userId, headline: $headline, bio: $bio, profileUrl: $profileUrl, avatarUrl: $avatarUrl, website: $website, location: $location, companyName: $companyName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SearchProfileCopyWith<$Res>  {
  factory $SearchProfileCopyWith(SearchProfile value, $Res Function(SearchProfile) _then) = _$SearchProfileCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'user_id') int userId, String headline, String bio,@JsonKey(name: 'profile_url') String profileUrl,@JsonKey(name: 'avatar_url') String avatarUrl, String website, String location,@JsonKey(name: 'company_name') String companyName,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$SearchProfileCopyWithImpl<$Res>
    implements $SearchProfileCopyWith<$Res> {
  _$SearchProfileCopyWithImpl(this._self, this._then);

  final SearchProfile _self;
  final $Res Function(SearchProfile) _then;

/// Create a copy of SearchProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? headline = null,Object? bio = null,Object? profileUrl = null,Object? avatarUrl = null,Object? website = null,Object? location = null,Object? companyName = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,profileUrl: null == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchProfile].
extension SearchProfilePatterns on SearchProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchProfile value)  $default,){
final _that = this;
switch (_that) {
case _SearchProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchProfile value)?  $default,){
final _that = this;
switch (_that) {
case _SearchProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_id')  int userId,  String headline,  String bio, @JsonKey(name: 'profile_url')  String profileUrl, @JsonKey(name: 'avatar_url')  String avatarUrl,  String website,  String location, @JsonKey(name: 'company_name')  String companyName, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchProfile() when $default != null:
return $default(_that.id,_that.userId,_that.headline,_that.bio,_that.profileUrl,_that.avatarUrl,_that.website,_that.location,_that.companyName,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_id')  int userId,  String headline,  String bio, @JsonKey(name: 'profile_url')  String profileUrl, @JsonKey(name: 'avatar_url')  String avatarUrl,  String website,  String location, @JsonKey(name: 'company_name')  String companyName, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SearchProfile():
return $default(_that.id,_that.userId,_that.headline,_that.bio,_that.profileUrl,_that.avatarUrl,_that.website,_that.location,_that.companyName,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'user_id')  int userId,  String headline,  String bio, @JsonKey(name: 'profile_url')  String profileUrl, @JsonKey(name: 'avatar_url')  String avatarUrl,  String website,  String location, @JsonKey(name: 'company_name')  String companyName, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SearchProfile() when $default != null:
return $default(_that.id,_that.userId,_that.headline,_that.bio,_that.profileUrl,_that.avatarUrl,_that.website,_that.location,_that.companyName,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchProfile implements SearchProfile {
  const _SearchProfile({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.headline, required this.bio, @JsonKey(name: 'profile_url') required this.profileUrl, @JsonKey(name: 'avatar_url') required this.avatarUrl, required this.website, required this.location, @JsonKey(name: 'company_name') required this.companyName, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _SearchProfile.fromJson(Map<String, dynamic> json) => _$SearchProfileFromJson(json);

@override final  int id;
@override@JsonKey(name: 'user_id') final  int userId;
@override final  String headline;
@override final  String bio;
@override@JsonKey(name: 'profile_url') final  String profileUrl;
@override@JsonKey(name: 'avatar_url') final  String avatarUrl;
@override final  String website;
@override final  String location;
@override@JsonKey(name: 'company_name') final  String companyName;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of SearchProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchProfileCopyWith<_SearchProfile> get copyWith => __$SearchProfileCopyWithImpl<_SearchProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.profileUrl, profileUrl) || other.profileUrl == profileUrl)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.website, website) || other.website == website)&&(identical(other.location, location) || other.location == location)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,headline,bio,profileUrl,avatarUrl,website,location,companyName,createdAt,updatedAt);

@override
String toString() {
  return 'SearchProfile(id: $id, userId: $userId, headline: $headline, bio: $bio, profileUrl: $profileUrl, avatarUrl: $avatarUrl, website: $website, location: $location, companyName: $companyName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SearchProfileCopyWith<$Res> implements $SearchProfileCopyWith<$Res> {
  factory _$SearchProfileCopyWith(_SearchProfile value, $Res Function(_SearchProfile) _then) = __$SearchProfileCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'user_id') int userId, String headline, String bio,@JsonKey(name: 'profile_url') String profileUrl,@JsonKey(name: 'avatar_url') String avatarUrl, String website, String location,@JsonKey(name: 'company_name') String companyName,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$SearchProfileCopyWithImpl<$Res>
    implements _$SearchProfileCopyWith<$Res> {
  __$SearchProfileCopyWithImpl(this._self, this._then);

  final _SearchProfile _self;
  final $Res Function(_SearchProfile) _then;

/// Create a copy of SearchProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? headline = null,Object? bio = null,Object? profileUrl = null,Object? avatarUrl = null,Object? website = null,Object? location = null,Object? companyName = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_SearchProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,profileUrl: null == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
