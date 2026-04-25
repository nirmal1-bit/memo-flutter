// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthenticationToken _$AuthenticationTokenFromJson(Map<String, dynamic> json) =>
    _AuthenticationToken(
      token: json['token'] as String,
      expiry: DateTime.parse(json['expiry'] as String),
    );

Map<String, dynamic> _$AuthenticationTokenToJson(
  _AuthenticationToken instance,
) => <String, dynamic>{
  'token': instance.token,
  'expiry': instance.expiry.toIso8601String(),
};

_AuthenticationTokenResponse _$AuthenticationTokenResponseFromJson(
  Map<String, dynamic> json,
) => _AuthenticationTokenResponse(
  authenticationToken: AuthenticationToken.fromJson(
    json['authentication_token'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AuthenticationTokenResponseToJson(
  _AuthenticationTokenResponse instance,
) => <String, dynamic>{'authentication_token': instance.authenticationToken};
