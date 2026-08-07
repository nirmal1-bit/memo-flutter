import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';
import 'package:memo/features/video_call/model/call_request_model.dart';

abstract final class VideoCallRepository {
  EitherResponse<ApiResponse<CallRequestModel>> startCall(int connectionId);
  EitherResponse<ApiResponse<String>> endCall(int sessionId, int connectionId);
  EitherResponse<ApiResponse<CallRequestModel>> joinCall(
    int connectionId,
    int sessionId,
  );
  EitherResponse<ApiResponse<String>> makeTranscript(
    int connectionId,
    String filepath,
    int sessionId,
  );
}

@LazySingleton(as: VideoCallRepository)
final class VideoCallRepositoryImpl extends BaseRemoteSource
    implements VideoCallRepository {
  VideoCallRepositoryImpl(super._dio, super._networkInfo);

  @override
  EitherResponse<ApiResponse<CallRequestModel>> startCall(
    int connectionId,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.post(ApiEndpoints.agora(connectionId));
        return ApiResponse(
          success: response.data['success'] as bool,
          data: CallRequestModel.fromJson(response.data['data']),
          message: response.data['message'] as String? ?? 'Success',
        );
      },
    );
    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> endCall(
    int connectionId,
    int sessionId,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.endCall(connectionId),
          data: {"video_call_session_id": sessionId},
        );
        return ApiResponse(
          success: response.data['success'] as bool,
          data: "success",

          message: response.data['message'] as String? ?? 'Success',
        );
      },
    );
    return response;
  }

  @override
  EitherResponse<ApiResponse<CallRequestModel>> joinCall(
    int connectionId,
    int sessionId,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.startCall(connectionId),
          data: {"video_call_session_id": sessionId},
        );
        return ApiResponse(
          success: response.data['success'] as bool,
          data: CallRequestModel.fromJson(response.data['data']),
          message: response.data['message'] as String? ?? 'Success',
        );
      },
    );
    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> makeTranscript(
    int connectionId,
    String filepath,
    int sessionId,
  ) async {
    final formData = FormData.fromMap({
      "audio": await MultipartFile.fromFile(filepath),
      "session_id": sessionId,
    });

    final response = await networkRequest(
      request: (dio) async {
        await dio.post(
          ApiEndpoints.makeTranscript(connectionId),
          data: formData,
        );
        return ApiResponse(success: true, data: "Success", message: "Success");
      },
    );
    return response;
  }
}
