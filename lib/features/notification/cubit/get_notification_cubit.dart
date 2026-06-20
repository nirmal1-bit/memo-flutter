import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/notification/data/response/notifications_response.dart';
import 'package:memo/features/notification/repository/notification_repository.dart';

@injectable
class GetNotificationCubit
    extends Cubit<BaseApiState<List<NotificationsResponse>>> {
  // we are initilizing ourself the BaseApiState to
  //initial because we want to emit
  //a loading state before we make the api call,
  //so that listeners always see a state transition
  // positional parameter required by default
  GetNotificationCubit(this.notificationRepository)
    : super(const BaseApiState.initial());
  final NotificationRepository notificationRepository;

  void getNotifications() async {
    emit(BaseApiState.loading());

    final response = await notificationRepository.getNotifications();

    emit(
      response.fold(
        (l) => l.when(
          serverError: (error) => BaseApiState.error(error),
          validationError: (validationError) =>
              BaseApiState.validationError(validationError),
          noInternet: (error) => BaseApiState.noInternet(),
        ),
        (r) {
          return BaseApiState.success(r.data);
        },
      ),
    );
  }
}
