import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';

part 'connection_response.freezed.dart';
part 'connection_response.g.dart';

@freezed
abstract class ConnectionResponse with _$ConnectionResponse {
  const factory ConnectionResponse({
    required int id,
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
    Profile? profile,
  }) = _OtherUserDetails;

  factory OtherUserDetails.fromJson(Map<String, dynamic> json) =>
      _$OtherUserDetailsFromJson(json);
}
