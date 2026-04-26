import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/video_call/model/call_request_model.dart';
import 'package:memo/features/video_call/repository/video_call_repository.dart';

@injectable
class StartVideoCallCubit extends Cubit<BaseApiState<CallRequestModel>> {
  StartVideoCallCubit({required this.videoCallRemoteSource})
    : super(const BaseApiState.initial());
  final VideoCallRepository videoCallRemoteSource;
  void startCall(int bookingId) async {
    emit(const BaseApiState.loading());
    final response = await videoCallRemoteSource.startCall(bookingId);
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
