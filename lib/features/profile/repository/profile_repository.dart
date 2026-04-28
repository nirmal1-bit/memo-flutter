import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';
import 'package:memo/features/profile/data/request/profile_request_model.dart';

abstract class ProfileRepository {
  EitherResponse<ApiResponse<String>> setupProfile(ProfileRequestModel request);
  EitherResponse<ApiResponse<String>> editProfile(ProfileRequestModel request);
}

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends BaseRemoteSource
    implements ProfileRepository {
  ProfileRepositoryImpl(super._dio, super._networkInfo);

  @override
  EitherResponse<ApiResponse<String>> setupProfile(
    ProfileRequestModel request,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.setupProfile,
          data: request.toJson(),
        );

        return ApiResponse(
          success: response.data['status'] ?? true,
          data: (response.data['message'] ?? 'success').toString(),
          message: (response.data['message'] ?? 'success').toString(),
        );
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> editProfile(
    ProfileRequestModel request,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.patch(
          ApiEndpoints.setupProfile,
          data: request.toJson(),
        );

        return ApiResponse(
          success: response.data['status'] ?? true,
          data: (response.data['message'] ?? 'success').toString(),
          message: (response.data['message'] ?? 'success').toString(),
        );
      },
    );

    return response;
  }
}
