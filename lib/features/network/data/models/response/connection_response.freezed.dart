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

 int get id;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'other_user_details') OtherUserDetails get otherUserDetails;
/// Create a copy of ConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectionResponseCopyWith<ConnectionResponse> get copyWith => _$ConnectionResponseCopyWithImpl<ConnectionResponse>(this as ConnectionResponse, _$identity);

  /// Serializes this ConnectionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.otherUserDetails, otherUserDetails) || other.otherUserDetails == otherUserDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,otherUserDetails);

@override
String toString() {
  return 'ConnectionResponse(id: $id, createdAt: $createdAt, otherUserDetails: $otherUserDetails)';
}


}

/// @nodoc
abstract mixin class $ConnectionResponseCopyWith<$Res>  {
  factory $ConnectionResponseCopyWith(ConnectionResponse value, $Res Function(ConnectionResponse) _then) = _$ConnectionResponseCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'other_user_details') OtherUserDetails otherUserDetails
});


$OtherUserDetailsCopyWith<$Res> get otherUserDetails;

}
/// @nodoc
class _$ConnectionResponseCopyWithImpl<$Res>
    implements $ConnectionResponseCopyWith<$Res> {
  _$ConnectionResponseCopyWithImpl(this._self, this._then);

  final ConnectionResponse _self;
  final $Res Function(ConnectionResponse) _then;

/// Create a copy of ConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? otherUserDetails = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,otherUserDetails: null == otherUserDetails ? _self.otherUserDetails : otherUserDetails // ignore: cast_nullable_to_non_nullable
as OtherUserDetails,
  ));
}
/// Create a copy of ConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OtherUserDetailsCopyWith<$Res> get otherUserDetails {
  
  return $OtherUserDetailsCopyWith<$Res>(_self.otherUserDetails, (value) {
    return _then(_self.copyWith(otherUserDetails: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'other_user_details')  OtherUserDetails otherUserDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectionResponse() when $default != null:
return $default(_that.id,_that.createdAt,_that.otherUserDetails);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'other_user_details')  OtherUserDetails otherUserDetails)  $default,) {final _that = this;
switch (_that) {
case _ConnectionResponse():
return $default(_that.id,_that.createdAt,_that.otherUserDetails);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'other_user_details')  OtherUserDetails otherUserDetails)?  $default,) {final _that = this;
switch (_that) {
case _ConnectionResponse() when $default != null:
return $default(_that.id,_that.createdAt,_that.otherUserDetails);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectionResponse implements ConnectionResponse {
  const _ConnectionResponse({required this.id, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'other_user_details') required this.otherUserDetails});
  factory _ConnectionResponse.fromJson(Map<String, dynamic> json) => _$ConnectionResponseFromJson(json);

@override final  int id;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'other_user_details') final  OtherUserDetails otherUserDetails;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.otherUserDetails, otherUserDetails) || other.otherUserDetails == otherUserDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,otherUserDetails);

@override
String toString() {
  return 'ConnectionResponse(id: $id, createdAt: $createdAt, otherUserDetails: $otherUserDetails)';
}


}

/// @nodoc
abstract mixin class _$ConnectionResponseCopyWith<$Res> implements $ConnectionResponseCopyWith<$Res> {
  factory _$ConnectionResponseCopyWith(_ConnectionResponse value, $Res Function(_ConnectionResponse) _then) = __$ConnectionResponseCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'other_user_details') OtherUserDetails otherUserDetails
});


@override $OtherUserDetailsCopyWith<$Res> get otherUserDetails;

}
/// @nodoc
class __$ConnectionResponseCopyWithImpl<$Res>
    implements _$ConnectionResponseCopyWith<$Res> {
  __$ConnectionResponseCopyWithImpl(this._self, this._then);

  final _ConnectionResponse _self;
  final $Res Function(_ConnectionResponse) _then;

/// Create a copy of ConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? otherUserDetails = null,}) {
  return _then(_ConnectionResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,otherUserDetails: null == otherUserDetails ? _self.otherUserDetails : otherUserDetails // ignore: cast_nullable_to_non_nullable
as OtherUserDetails,
  ));
}

/// Create a copy of ConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OtherUserDetailsCopyWith<$Res> get otherUserDetails {
  
  return $OtherUserDetailsCopyWith<$Res>(_self.otherUserDetails, (value) {
    return _then(_self.copyWith(otherUserDetails: value));
  });
}
}


/// @nodoc
mixin _$OtherUserDetails {

 int get id;@JsonKey(name: 'created_at') DateTime get createdAt; String get name; String get email; bool get activated; String get role;@JsonKey(name: 'trial_left') int get trialLeft;@JsonKey(name: 'is_premium') bool get isPremium;@JsonKey(name: 'revenue_id') String get revenueId; Profile? get profile;
/// Create a copy of OtherUserDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtherUserDetailsCopyWith<OtherUserDetails> get copyWith => _$OtherUserDetailsCopyWithImpl<OtherUserDetails>(this as OtherUserDetails, _$identity);

  /// Serializes this OtherUserDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtherUserDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.activated, activated) || other.activated == activated)&&(identical(other.role, role) || other.role == role)&&(identical(other.trialLeft, trialLeft) || other.trialLeft == trialLeft)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.revenueId, revenueId) || other.revenueId == revenueId)&&(identical(other.profile, profile) || other.profile == profile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,name,email,activated,role,trialLeft,isPremium,revenueId,profile);

@override
String toString() {
  return 'OtherUserDetails(id: $id, createdAt: $createdAt, name: $name, email: $email, activated: $activated, role: $role, trialLeft: $trialLeft, isPremium: $isPremium, revenueId: $revenueId, profile: $profile)';
}


}

/// @nodoc
abstract mixin class $OtherUserDetailsCopyWith<$Res>  {
  factory $OtherUserDetailsCopyWith(OtherUserDetails value, $Res Function(OtherUserDetails) _then) = _$OtherUserDetailsCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'created_at') DateTime createdAt, String name, String email, bool activated, String role,@JsonKey(name: 'trial_left') int trialLeft,@JsonKey(name: 'is_premium') bool isPremium,@JsonKey(name: 'revenue_id') String revenueId, Profile? profile
});


$ProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class _$OtherUserDetailsCopyWithImpl<$Res>
    implements $OtherUserDetailsCopyWith<$Res> {
  _$OtherUserDetailsCopyWithImpl(this._self, this._then);

  final OtherUserDetails _self;
  final $Res Function(OtherUserDetails) _then;

/// Create a copy of OtherUserDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? name = null,Object? email = null,Object? activated = null,Object? role = null,Object? trialLeft = null,Object? isPremium = null,Object? revenueId = null,Object? profile = freezed,}) {
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
as String,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Profile?,
  ));
}
/// Create a copy of OtherUserDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [OtherUserDetails].
extension OtherUserDetailsPatterns on OtherUserDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtherUserDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtherUserDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtherUserDetails value)  $default,){
final _that = this;
switch (_that) {
case _OtherUserDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtherUserDetails value)?  $default,){
final _that = this;
switch (_that) {
case _OtherUserDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'created_at')  DateTime createdAt,  String name,  String email,  bool activated,  String role, @JsonKey(name: 'trial_left')  int trialLeft, @JsonKey(name: 'is_premium')  bool isPremium, @JsonKey(name: 'revenue_id')  String revenueId,  Profile? profile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtherUserDetails() when $default != null:
return $default(_that.id,_that.createdAt,_that.name,_that.email,_that.activated,_that.role,_that.trialLeft,_that.isPremium,_that.revenueId,_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'created_at')  DateTime createdAt,  String name,  String email,  bool activated,  String role, @JsonKey(name: 'trial_left')  int trialLeft, @JsonKey(name: 'is_premium')  bool isPremium, @JsonKey(name: 'revenue_id')  String revenueId,  Profile? profile)  $default,) {final _that = this;
switch (_that) {
case _OtherUserDetails():
return $default(_that.id,_that.createdAt,_that.name,_that.email,_that.activated,_that.role,_that.trialLeft,_that.isPremium,_that.revenueId,_that.profile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'created_at')  DateTime createdAt,  String name,  String email,  bool activated,  String role, @JsonKey(name: 'trial_left')  int trialLeft, @JsonKey(name: 'is_premium')  bool isPremium, @JsonKey(name: 'revenue_id')  String revenueId,  Profile? profile)?  $default,) {final _that = this;
switch (_that) {
case _OtherUserDetails() when $default != null:
return $default(_that.id,_that.createdAt,_that.name,_that.email,_that.activated,_that.role,_that.trialLeft,_that.isPremium,_that.revenueId,_that.profile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OtherUserDetails implements OtherUserDetails {
  const _OtherUserDetails({required this.id, @JsonKey(name: 'created_at') required this.createdAt, required this.name, required this.email, required this.activated, required this.role, @JsonKey(name: 'trial_left') required this.trialLeft, @JsonKey(name: 'is_premium') required this.isPremium, @JsonKey(name: 'revenue_id') required this.revenueId, this.profile});
  factory _OtherUserDetails.fromJson(Map<String, dynamic> json) => _$OtherUserDetailsFromJson(json);

@override final  int id;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override final  String name;
@override final  String email;
@override final  bool activated;
@override final  String role;
@override@JsonKey(name: 'trial_left') final  int trialLeft;
@override@JsonKey(name: 'is_premium') final  bool isPremium;
@override@JsonKey(name: 'revenue_id') final  String revenueId;
@override final  Profile? profile;

/// Create a copy of OtherUserDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtherUserDetailsCopyWith<_OtherUserDetails> get copyWith => __$OtherUserDetailsCopyWithImpl<_OtherUserDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtherUserDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtherUserDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.activated, activated) || other.activated == activated)&&(identical(other.role, role) || other.role == role)&&(identical(other.trialLeft, trialLeft) || other.trialLeft == trialLeft)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.revenueId, revenueId) || other.revenueId == revenueId)&&(identical(other.profile, profile) || other.profile == profile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,name,email,activated,role,trialLeft,isPremium,revenueId,profile);

@override
String toString() {
  return 'OtherUserDetails(id: $id, createdAt: $createdAt, name: $name, email: $email, activated: $activated, role: $role, trialLeft: $trialLeft, isPremium: $isPremium, revenueId: $revenueId, profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$OtherUserDetailsCopyWith<$Res> implements $OtherUserDetailsCopyWith<$Res> {
  factory _$OtherUserDetailsCopyWith(_OtherUserDetails value, $Res Function(_OtherUserDetails) _then) = __$OtherUserDetailsCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'created_at') DateTime createdAt, String name, String email, bool activated, String role,@JsonKey(name: 'trial_left') int trialLeft,@JsonKey(name: 'is_premium') bool isPremium,@JsonKey(name: 'revenue_id') String revenueId, Profile? profile
});


@override $ProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class __$OtherUserDetailsCopyWithImpl<$Res>
    implements _$OtherUserDetailsCopyWith<$Res> {
  __$OtherUserDetailsCopyWithImpl(this._self, this._then);

  final _OtherUserDetails _self;
  final $Res Function(_OtherUserDetails) _then;

/// Create a copy of OtherUserDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? name = null,Object? email = null,Object? activated = null,Object? role = null,Object? trialLeft = null,Object? isPremium = null,Object? revenueId = null,Object? profile = freezed,}) {
  return _then(_OtherUserDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,activated: null == activated ? _self.activated : activated // ignore: cast_nullable_to_non_nullable
as bool,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,trialLeft: null == trialLeft ? _self.trialLeft : trialLeft // ignore: cast_nullable_to_non_nullable
as int,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,revenueId: null == revenueId ? _self.revenueId : revenueId // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Profile?,
  ));
}

/// Create a copy of OtherUserDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
