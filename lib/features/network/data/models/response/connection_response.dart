import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_response.freezed.dart';
part 'connection_response.g.dart';

@freezed
abstract class ConnectionResponse with _$ConnectionResponse {
  const factory ConnectionResponse({
    required int id,
    @JsonKey(name: 'user_profile') required UserProfile userProfile,
  }) = _ConnectionResponse;

  factory ConnectionResponse.fromJson(Map<String, dynamic> json) =>
      _$ConnectionResponseFromJson(json);
}

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    required String name,
    required String headline,
    required String bio,
    @JsonKey(name: 'profile_url') required String profileUrl,
    required String location,
    required int age,
    required String gender,
    required List<String> interests,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
