import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/notification/repository/notification_repository.dart';

@injectable
class GetUnreadCountCubit extends Cubit<BaseApiState<int>> {
  // we are initilizing ourself the BaseApiState to
  //initial because we want to emit
  //a loading state before we make the api call,
  //so that listeners always see a state transition
  // positional parameter required by default
  GetUnreadCountCubit(this.notificationRepository)
    : super(const BaseApiState.initial());
  final NotificationRepository notificationRepository;

  void getUnreadCount() async {
    emit(BaseApiState.loading());

    final response = await notificationRepository.getUnreadCount();

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
