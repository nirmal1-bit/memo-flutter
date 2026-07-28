import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';
import 'package:memo/features/auth/data/models/request/login_request_model.dart';
import 'package:memo/features/auth/data/models/request/fcm_request.dart';
import 'package:memo/features/auth/data/models/request/new_password_request.dart';
import 'package:memo/features/auth/data/models/request/signup_request_model.dart';
import 'package:memo/features/auth/data/models/response/authentication_token.dart';

abstract class AuthRepository {
  EitherResponse<ApiResponse<String>> signUp(SignupRequestModel request);
  EitherResponse<ApiResponse<String>> verifyToken(String otp);
  EitherResponse<ApiResponse<String>> resendToken(String email);
  EitherResponse<ApiResponse<AuthenticationToken>> login(
    LoginRequestModel request, {
    File? image,
  });
  EitherResponse<ApiResponse<bool>> getFaceVerificationStatus(
    LoginRequestModel request,
  );
  EitherResponse<ApiResponse<String>> requestToken(String email);

  EitherResponse<ApiResponse<String>> verifyTokenForgetPassword(String otp);

  EitherResponse<ApiResponse<String>> makeNewPassword(
    NewPasswordRequest request,
  );

  EitherResponse<ApiResponse<String>> sendToken(DeviceTokenRequest request);
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRemoteSource implements AuthRepository {
  AuthRepositoryImpl(super._dio, super._networkInfo);

  @override
  EitherResponse<ApiResponse<String>> signUp(SignupRequestModel request) async {
    final response = await networkRequest(
      request: (dio) async {
        await dio.post(ApiEndpoints.register, data: request.toJson());
        return ApiResponse(success: true, data: "success", message: "success");
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> resendToken(String email) async {
    final response = await networkRequest(
      request: (dio) async {
        await dio.get(ApiEndpoints.resendToken, data: {"email": email});
        return ApiResponse(success: true, data: "success", message: "success");
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> verifyToken(String otp) async {
    final response = await networkRequest(
      request: (dio) async {
        await dio.patch(ApiEndpoints.verifyToken, data: {"token": otp});
        return ApiResponse(success: true, data: "success", message: "success");
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<AuthenticationToken>> login(
    LoginRequestModel request, {
    File? image,
  }) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.login,
          // The Go login handler always parses multipart form fields. The image
          // is optional for users who have not enrolled face verification.
          data: FormData.fromMap({
            ...request.toJson(),
            if (image != null)
              'image': await MultipartFile.fromFile(
                image.path,
                filename: image.uri.pathSegments.last,
              ),
          }),
        );
        return ApiResponse(
          success: true,
          data: AuthenticationToken.fromJson(
            response.data["authentication_token"],
          ),
          message: "success",
        );
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<bool>> getFaceVerificationStatus(
    LoginRequestModel request,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.get(
          ApiEndpoints.faceVerificationStatus,
          data: request.toJson(),
        );
        return ApiResponse(
          success: true,
          data: response.data['face_verified'] as bool,
          message: 'success',
        );
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> requestToken(String email) async {
    final response = await networkRequest(
      request: (dio) async {
        await dio.get(ApiEndpoints.requestToken, data: {"email": email});
        return ApiResponse(success: true, data: "success", message: "success");
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> verifyTokenForgetPassword(
    String otp,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        await dio.patch(ApiEndpoints.verifyForgetToken, data: {"token": otp});
        return ApiResponse(success: true, data: "success", message: "success");
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> makeNewPassword(
    NewPasswordRequest request,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        await dio.post(ApiEndpoints.resetPassword, data: request.toJson());
        return ApiResponse(success: true, data: "success", message: "success");
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> sendToken(
    DeviceTokenRequest request,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        await dio.post(ApiEndpoints.fcmToken, data: request.toJson());
        return ApiResponse(success: true, data: "success", message: "success");
      },
    );

    return response;
  }
}
