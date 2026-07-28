import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';
import 'package:memo/features/notification/data/response/notifications_response.dart';

abstract class NotificationRepository {
  EitherResponse<ApiResponseWithPagination<NotificationsResponse>>
  getNotifications();
  EitherResponse<ApiResponse<int>> getUnreadCount();

  EitherResponse<ApiResponse<String>> markAsRead();
}

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl extends BaseRemoteSource
    implements NotificationRepository {
  NotificationRepositoryImpl(super._dio, super._networkInfo);

  @override
  EitherResponse<ApiResponseWithPagination<NotificationsResponse>>
  getNotifications() {
    final response = networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.notifications);
        final list = response.data['notifications'] as List<dynamic>;
        return ApiResponseWithPagination(
          success: true,
          data: list.map((e) => NotificationsResponse.fromJson(e)).toList(),
          message: "success",
        );
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<int>> getUnreadCount() {
    final response = networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.notificationsCount);
        return ApiResponse(
          success: true,
          data: response.data['unread_count'] as int,
          message: "success",
        );
      },
    );
    return response;
  }

  @override
  EitherResponse<ApiResponse<String>> markAsRead() {
    final response = networkRequest(
      request: (dio) async {
        await dio.patch(ApiEndpoints.notifications);
        return ApiResponse(success: true, data: "success", message: "success");
      },
    );
    return response;
  }
}
