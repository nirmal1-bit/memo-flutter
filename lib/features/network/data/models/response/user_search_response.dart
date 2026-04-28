import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_search_response.freezed.dart';
part 'user_search_response.g.dart';

@freezed
abstract class UserSearchResponse with _$UserSearchResponse {
  const factory UserSearchResponse({
    required SearchUser user,
    SearchProfile? profile,
  }) = _UserSearchResponse;

  factory UserSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResponseFromJson(json);
}

@freezed
abstract class SearchUser with _$SearchUser {
  const factory SearchUser({
    required int id,

    @JsonKey(name: 'created_at') required DateTime createdAt,

    required String name,
    required String email,
    required bool activated,
    required String role,

    @JsonKey(name: 'trial_left') required int trialLeft,

    @JsonKey(name: 'is_premium') required bool isPremium,

    @JsonKey(name: 'revenue_id') required String revenueId,
  }) = _SearchUser;

  factory SearchUser.fromJson(Map<String, dynamic> json) =>
      _$SearchUserFromJson(json);
}

@freezed
abstract class SearchProfile with _$SearchProfile {
  const factory SearchProfile({
    required int id,

    @JsonKey(name: 'user_id') required int userId,

    required String headline,
    required String bio,

    @JsonKey(name: 'profile_url') required String profileUrl,

    @JsonKey(name: 'avatar_url') required String avatarUrl,

    required String website,
    required String location,

    @JsonKey(name: 'company_name') required String companyName,

    @JsonKey(name: 'created_at') required DateTime createdAt,

    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _SearchProfile;

  factory SearchProfile.fromJson(Map<String, dynamic> json) =>
      _$SearchProfileFromJson(json);
}
