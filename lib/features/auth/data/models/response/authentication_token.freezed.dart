// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthenticationToken {

 String get token; DateTime get expiry;
/// Create a copy of AuthenticationToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationTokenCopyWith<AuthenticationToken> get copyWith => _$AuthenticationTokenCopyWithImpl<AuthenticationToken>(this as AuthenticationToken, _$identity);

  /// Serializes this AuthenticationToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationToken&&(identical(other.token, token) || other.token == token)&&(identical(other.expiry, expiry) || other.expiry == expiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,expiry);

@override
String toString() {
  return 'AuthenticationToken(token: $token, expiry: $expiry)';
}


}

/// @nodoc
abstract mixin class $AuthenticationTokenCopyWith<$Res>  {
  factory $AuthenticationTokenCopyWith(AuthenticationToken value, $Res Function(AuthenticationToken) _then) = _$AuthenticationTokenCopyWithImpl;
@useResult
$Res call({
 String token, DateTime expiry
});




}
/// @nodoc
class _$AuthenticationTokenCopyWithImpl<$Res>
    implements $AuthenticationTokenCopyWith<$Res> {
  _$AuthenticationTokenCopyWithImpl(this._self, this._then);

  final AuthenticationToken _self;
  final $Res Function(AuthenticationToken) _then;

/// Create a copy of AuthenticationToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? expiry = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthenticationToken].
extension AuthenticationTokenPatterns on AuthenticationToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthenticationToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthenticationToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthenticationToken value)  $default,){
final _that = this;
switch (_that) {
case _AuthenticationToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthenticationToken value)?  $default,){
final _that = this;
switch (_that) {
case _AuthenticationToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  DateTime expiry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthenticationToken() when $default != null:
return $default(_that.token,_that.expiry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  DateTime expiry)  $default,) {final _that = this;
switch (_that) {
case _AuthenticationToken():
return $default(_that.token,_that.expiry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  DateTime expiry)?  $default,) {final _that = this;
switch (_that) {
case _AuthenticationToken() when $default != null:
return $default(_that.token,_that.expiry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthenticationToken implements AuthenticationToken {
  const _AuthenticationToken({required this.token, required this.expiry});
  factory _AuthenticationToken.fromJson(Map<String, dynamic> json) => _$AuthenticationTokenFromJson(json);

@override final  String token;
@override final  DateTime expiry;

/// Create a copy of AuthenticationToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticationTokenCopyWith<_AuthenticationToken> get copyWith => __$AuthenticationTokenCopyWithImpl<_AuthenticationToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthenticationTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthenticationToken&&(identical(other.token, token) || other.token == token)&&(identical(other.expiry, expiry) || other.expiry == expiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,expiry);

@override
String toString() {
  return 'AuthenticationToken(token: $token, expiry: $expiry)';
}


}

/// @nodoc
abstract mixin class _$AuthenticationTokenCopyWith<$Res> implements $AuthenticationTokenCopyWith<$Res> {
  factory _$AuthenticationTokenCopyWith(_AuthenticationToken value, $Res Function(_AuthenticationToken) _then) = __$AuthenticationTokenCopyWithImpl;
@override @useResult
$Res call({
 String token, DateTime expiry
});




}
/// @nodoc
class __$AuthenticationTokenCopyWithImpl<$Res>
    implements _$AuthenticationTokenCopyWith<$Res> {
  __$AuthenticationTokenCopyWithImpl(this._self, this._then);

  final _AuthenticationToken _self;
  final $Res Function(_AuthenticationToken) _then;

/// Create a copy of AuthenticationToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? expiry = null,}) {
  return _then(_AuthenticationToken(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$AuthenticationTokenResponse {

@JsonKey(name: 'authentication_token') AuthenticationToken get authenticationToken;
/// Create a copy of AuthenticationTokenResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationTokenResponseCopyWith<AuthenticationTokenResponse> get copyWith => _$AuthenticationTokenResponseCopyWithImpl<AuthenticationTokenResponse>(this as AuthenticationTokenResponse, _$identity);

  /// Serializes this AuthenticationTokenResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationTokenResponse&&(identical(other.authenticationToken, authenticationToken) || other.authenticationToken == authenticationToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authenticationToken);

@override
String toString() {
  return 'AuthenticationTokenResponse(authenticationToken: $authenticationToken)';
}


}

/// @nodoc
abstract mixin class $AuthenticationTokenResponseCopyWith<$Res>  {
  factory $AuthenticationTokenResponseCopyWith(AuthenticationTokenResponse value, $Res Function(AuthenticationTokenResponse) _then) = _$AuthenticationTokenResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'authentication_token') AuthenticationToken authenticationToken
});


$AuthenticationTokenCopyWith<$Res> get authenticationToken;

}
/// @nodoc
class _$AuthenticationTokenResponseCopyWithImpl<$Res>
    implements $AuthenticationTokenResponseCopyWith<$Res> {
  _$AuthenticationTokenResponseCopyWithImpl(this._self, this._then);

  final AuthenticationTokenResponse _self;
  final $Res Function(AuthenticationTokenResponse) _then;

/// Create a copy of AuthenticationTokenResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authenticationToken = null,}) {
  return _then(_self.copyWith(
authenticationToken: null == authenticationToken ? _self.authenticationToken : authenticationToken // ignore: cast_nullable_to_non_nullable
as AuthenticationToken,
  ));
}
/// Create a copy of AuthenticationTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthenticationTokenCopyWith<$Res> get authenticationToken {
  
  return $AuthenticationTokenCopyWith<$Res>(_self.authenticationToken, (value) {
    return _then(_self.copyWith(authenticationToken: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthenticationTokenResponse].
extension AuthenticationTokenResponsePatterns on AuthenticationTokenResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthenticationTokenResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthenticationTokenResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthenticationTokenResponse value)  $default,){
final _that = this;
switch (_that) {
case _AuthenticationTokenResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthenticationTokenResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AuthenticationTokenResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'authentication_token')  AuthenticationToken authenticationToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthenticationTokenResponse() when $default != null:
return $default(_that.authenticationToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'authentication_token')  AuthenticationToken authenticationToken)  $default,) {final _that = this;
switch (_that) {
case _AuthenticationTokenResponse():
return $default(_that.authenticationToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'authentication_token')  AuthenticationToken authenticationToken)?  $default,) {final _that = this;
switch (_that) {
case _AuthenticationTokenResponse() when $default != null:
return $default(_that.authenticationToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthenticationTokenResponse implements AuthenticationTokenResponse {
  const _AuthenticationTokenResponse({@JsonKey(name: 'authentication_token') required this.authenticationToken});
  factory _AuthenticationTokenResponse.fromJson(Map<String, dynamic> json) => _$AuthenticationTokenResponseFromJson(json);

@override@JsonKey(name: 'authentication_token') final  AuthenticationToken authenticationToken;

/// Create a copy of AuthenticationTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticationTokenResponseCopyWith<_AuthenticationTokenResponse> get copyWith => __$AuthenticationTokenResponseCopyWithImpl<_AuthenticationTokenResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthenticationTokenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthenticationTokenResponse&&(identical(other.authenticationToken, authenticationToken) || other.authenticationToken == authenticationToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authenticationToken);

@override
String toString() {
  return 'AuthenticationTokenResponse(authenticationToken: $authenticationToken)';
}


}

/// @nodoc
abstract mixin class _$AuthenticationTokenResponseCopyWith<$Res> implements $AuthenticationTokenResponseCopyWith<$Res> {
  factory _$AuthenticationTokenResponseCopyWith(_AuthenticationTokenResponse value, $Res Function(_AuthenticationTokenResponse) _then) = __$AuthenticationTokenResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'authentication_token') AuthenticationToken authenticationToken
});


@override $AuthenticationTokenCopyWith<$Res> get authenticationToken;

}
/// @nodoc
class __$AuthenticationTokenResponseCopyWithImpl<$Res>
    implements _$AuthenticationTokenResponseCopyWith<$Res> {
  __$AuthenticationTokenResponseCopyWithImpl(this._self, this._then);

  final _AuthenticationTokenResponse _self;
  final $Res Function(_AuthenticationTokenResponse) _then;

/// Create a copy of AuthenticationTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authenticationToken = null,}) {
  return _then(_AuthenticationTokenResponse(
authenticationToken: null == authenticationToken ? _self.authenticationToken : authenticationToken // ignore: cast_nullable_to_non_nullable
as AuthenticationToken,
  ));
}

/// Create a copy of AuthenticationTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthenticationTokenCopyWith<$Res> get authenticationToken {
  
  return $AuthenticationTokenCopyWith<$Res>(_self.authenticationToken, (value) {
    return _then(_self.copyWith(authenticationToken: value));
  });
}
}

// dart format on
