import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_response.freezed.dart';
part 'connection_response.g.dart';

@freezed
abstract class ConnectionResponse with _$ConnectionResponse {
  const factory ConnectionResponse({
    required int id,
    @JsonKey(name: 'user_one') required int userOne,
    @JsonKey(name: 'user_two') required int userTwo,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'other_user_details')
    required OtherUserDetails otherUserDetails,
  }) = _ConnectionResponse;

  factory ConnectionResponse.fromJson(Map<String, dynamic> json) =>
      _$ConnectionResponseFromJson(json);
}

@freezed
abstract class OtherUserDetails with _$OtherUserDetails {
  const factory OtherUserDetails({
    required int id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required String name,
    required String email,
    required bool activated,
    required String role,
    @JsonKey(name: 'trial_left') required int trialLeft,
    @JsonKey(name: 'is_premium') required bool isPremium,
    @JsonKey(name: 'revenue_id') required String revenueId,
    required Profile profile,
  }) = _OtherUserDetails;

  factory OtherUserDetails.fromJson(Map<String, dynamic> json) =>
      _$OtherUserDetailsFromJson(json);
}

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
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
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
