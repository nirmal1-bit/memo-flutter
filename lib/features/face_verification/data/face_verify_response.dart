import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_verify_response.freezed.dart';
part 'face_verify_response.g.dart';

@freezed
abstract class FaceVerifyResponse with _$FaceVerifyResponse {
  const factory FaceVerifyResponse({
    required double similarity,
    required bool verified,
  }) = _FaceVerifyResponse;

  factory FaceVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$FaceVerifyResponseFromJson(json);
}
