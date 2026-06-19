import 'package:freezed_annotation/freezed_annotation.dart';

part 'matches_response.freezed.dart';
part 'matches_response.g.dart';

// @freezed
// abstract class MatchesResponse with _$MatchesResponse {
//   const factory MatchesResponse({
//     @JsonKey(name: 'matches_response') required List<MatchesResponse> matches,
//   }) = _MatchesResponse;

//   factory MatchesResponse.fromJson(Map<String, dynamic> json) =>
//       _$MatchesResponseFromJson(json);
// }

@freezed
abstract class MatchesResponse with _$MatchesResponse {
  const factory MatchesResponse({
    required int id,
    required String name,
    @JsonKey(name: 'user_id') required int userId,
    required String headline,
    required String bio,
    @JsonKey(name: 'profile_url') required String profileUrl,
    required String location,
    required int age,

    required String gender,

    required List<String> interests,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    required double similarity,
  }) = _MatchesResponse;

  factory MatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$MatchesResponseFromJson(json);
}
