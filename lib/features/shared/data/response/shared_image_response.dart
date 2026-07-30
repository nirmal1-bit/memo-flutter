import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared_image_response.freezed.dart';
part 'shared_image_response.g.dart';

@freezed
abstract class SharedImageResponse with _$SharedImageResponse {
  const factory SharedImageResponse({
    required int id,
    @JsonKey(name: 'connection_id') required int connectionId,
    @JsonKey(name: 'uploaded_by') required int uploadedBy,
    @JsonKey(name: 'image_url') required String imageUrl,
    @Default('') String description,
    @Default('other') String category,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _SharedImageResponse;

  factory SharedImageResponse.fromJson(Map<String, dynamic> json) =>
      _$SharedImageResponseFromJson(json);
}
