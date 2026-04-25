import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_token.freezed.dart';
part 'authentication_token.g.dart';

@freezed
abstract class AuthenticationToken with _$AuthenticationToken {
  const factory AuthenticationToken({
    required String token,
    required DateTime expiry,
  }) = _AuthenticationToken;

  factory AuthenticationToken.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationTokenFromJson(json);
}

@freezed
abstract class AuthenticationTokenResponse with _$AuthenticationTokenResponse {
  const factory AuthenticationTokenResponse({
    @JsonKey(name: 'authentication_token')
    required AuthenticationToken authenticationToken,
  }) = _AuthenticationTokenResponse;

  factory AuthenticationTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationTokenResponseFromJson(json);
}
