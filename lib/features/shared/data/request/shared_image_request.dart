import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared_image_request.freezed.dart';
part 'shared_image_request.g.dart';

@freezed
abstract class SharedImageRequest with _$SharedImageRequest {
  const factory SharedImageRequest({
    @JsonKey(name: 'image_url') required String imageUrl,
    required String description,
    required String category,
  }) = _SharedImageRequest;

  factory SharedImageRequest.fromJson(Map<String, dynamic> json) =>
      _$SharedImageRequestFromJson(json);
}
