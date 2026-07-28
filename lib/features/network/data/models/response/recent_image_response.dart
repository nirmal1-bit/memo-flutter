import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_image_response.freezed.dart';
part 'recent_image_response.g.dart';

@freezed
abstract class RecentImageResponse with _$RecentImageResponse {
  const factory RecentImageResponse({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    required String url,
    required String? description,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _RecentImageResponse;

  factory RecentImageResponse.fromJson(Map<String, dynamic> json) =>
      _$RecentImageResponseFromJson(json);
}
