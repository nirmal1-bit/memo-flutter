import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/constants/connection_request_status.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';

abstract class NetworkRepository {
  EitherResponse<ApiResponseWithPagination<ConnectionResponse>>
  listConnections();

  EitherResponse<ApiResponseWithPagination<ConnectionResponse>>
  listReceivedConnections();

  EitherResponse<ApiResponseWithPagination<ConnectionResponse>>
  listSentConnections();
  EitherResponse<ApiResponse<UserProfileResponse>> getUserProfile();

  EitherResponse<ApiResponse<String>> sendConnectionRequest(int userId);

  EitherResponse<ApiResponse<List<Profile>>> searchUser(String query);

  EitherResponse<ApiResponse<String>> acceptConnectionRequest(int requestId);

  EitherResponse<ApiResponse<String>> rejectConnectionRequest(int requestId);

  EitherResponse<ApiResponse<String>> cancelConnectionRequest(int requestId);
}

@LazySingleton(as: NetworkRepository)
class NetworkRepositoryImpl extends BaseRemoteSource
    implements NetworkRepository {
  NetworkRepositoryImpl(super._dio, super._networkInfo);

  @override
  EitherResponse<ApiResponseWithPagination<ConnectionResponse>>
  listConnections() async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.listConnections);

        final list = response.data["connections"] as List<dynamic>;

        return ApiResponseWithPagination(
          success: response.data["status"] ?? true,
          data: list.map((e) => ConnectionResponse.fromJson(e)).toList(),
          message: (response.data["message"] ?? "success").toString(),
        );
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponseWithPagination<ConnectionResponse>>
  listReceivedConnections() async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.listReceivedConnections);

        final list = response.data["connection_requests"] as List<dynamic>;

        return ApiResponseWithPagination(
          success: response.data["status"] ?? true,
          data: list.map((e) => ConnectionResponse.fromJson(e)).toList(),
          message: (response.data["message"] ?? "success").toString(),
        );
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponseWithPagination<ConnectionResponse>>
  listSentConnections() async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.listSentConnections);

        final list = response.data["connection_requests"] as List<dynamic>;

        return ApiResponseWithPagination(
          success: response.data["status"] ?? true,
          data: list.map((e) => ConnectionResponse.fromJson(e)).toList(),
          message: (response.data["message"] ?? "success").toString(),
        );
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<UserProfileResponse>> getUserProfile() async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.user);

        return ApiResponse(
          success: response.data["status"] ?? true,
          data: UserProfileResponse.fromJson(response.data['user']),
          message: (response.data["message"] ?? "success").toString(),
        );
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> sendConnectionRequest(int userId) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.sendRequest,
          data: {'receiver_id': userId},
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
  EitherResponse<ApiResponse<List<Profile>>> searchUser(String query) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.get(
          ApiEndpoints.searchUser,
          queryParameters: {'q': query},
        );

        final dynamic rawData = response.data;
        final dynamic rawUsers = rawData is List<dynamic>
            ? rawData
            : rawData is Map<String, dynamic>
            ? (rawData['users'] ?? rawData['user'])
            : <dynamic>[];
        final List<dynamic> users = rawUsers is List<dynamic>
            ? rawUsers
            : <dynamic>[];

        return ApiResponse(
          success: response.data['status'] ?? true,
          data: users
              .map((item) => Profile.fromJson(item as Map<String, dynamic>))
              .toList(),
          message: (response.data['message'] ?? 'success').toString(),
        );
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> acceptConnectionRequest(int requestId) {
    return updateConnectionStatus(
      requestId: requestId,
      status: ConnectionRequestStatus.accepted,
    );
  }

  @override
  EitherResponse<ApiResponse<String>> rejectConnectionRequest(int requestId) {
    return updateConnectionStatus(
      requestId: requestId,
      status: ConnectionRequestStatus.rejected,
    );
  }

  @override
  EitherResponse<ApiResponse<String>> cancelConnectionRequest(int requestId) {
    return updateConnectionStatus(
      requestId: requestId,
      status: ConnectionRequestStatus.rejected,
    );
  }

  EitherResponse<ApiResponse<String>> updateConnectionStatus({
    required int requestId,
    required String status,
  }) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.patch(
          ApiEndpoints.connectionRequest(requestId),
          data: {'status': status},
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
