import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_response.freezed.dart';
part 'user_profile_response.g.dart';

@freezed
abstract class UserProfileResponse with _$UserProfileResponse {
  const factory UserProfileResponse({
    required int id,

    @JsonKey(name: 'created_at') required DateTime createdAt,

    required String name,
    required String email,
    required bool activated,

    @JsonKey(name: 'trial_left') required int trialLeft,

    @JsonKey(name: 'is_premium') required bool isPremium,

    @JsonKey(name: 'revenue_id') required String revenueId,

    Profile? profile,
  }) = _UserProfileResponse;

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);
}

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required int id,

    @JsonKey(name: 'user_id') required int userId,

    required String headline,
    required String bio,
    String? name,

    @JsonKey(name: 'profile_url') required String profileUrl,

    @JsonKey(name: 'avatar_url') String? avatarUrl,

    required String location,

    required int age,
    required String gender,

    required List<String> interests,

    @JsonKey(name: 'created_at') required DateTime createdAt,

    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
