import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';
import 'package:memo/features/face_verification/data/face_verify_response.dart';

abstract class FaceRepository {
  EitherResponse<ApiResponse<FaceVerifyResponse>> verifyFace(File image);
  EitherResponse<ApiResponse<String>> generateEmbeddings(File image);
}

@LazySingleton(as: FaceRepository)
class FaceRepositoryImpl extends BaseRemoteSource implements FaceRepository {
  FaceRepositoryImpl(super._dio, super._networkInfo);

  @override
  EitherResponse<ApiResponse<FaceVerifyResponse>> verifyFace(File image) async {
    print(
      "FaceRepositoryImpl: verifyFace called with image path: ${image.path}",
    );
    final response = await networkRequest(
      request: (dio) async {
        final formData = FormData.fromMap({
          'image': await MultipartFile.fromFile(image.path),
        });

        final response = await dio.post(
          ApiEndpoints.verifyFace,
          data: formData,
        );

        return ApiResponse(
          success: true,
          data: FaceVerifyResponse.fromJson(response.data),
          message: "success",
        );
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> generateEmbeddings(File image) async {
    final response = await networkRequest(
      request: (dio) async {
        final formData = FormData.fromMap({
          'image': await MultipartFile.fromFile(image.path),
        });

        await dio.post(ApiEndpoints.createFace, data: formData);

        return ApiResponse(success: true, data: "success", message: "success");
      },
    );

    return response;
  }
}
