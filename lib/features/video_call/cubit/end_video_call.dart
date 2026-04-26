import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/video_call/repository/video_call_repository.dart';

@injectable
class EndVideoCall extends Cubit<BaseApiState<String>> {
  EndVideoCall({required this.videoCallRemoteSource})
    : super(const BaseApiState.initial());
  final VideoCallRepository videoCallRemoteSource;
  void endCall(int bookingId, int sessionId) async {
    emit(const BaseApiState.loading());
    final response = await videoCallRemoteSource.endCall(bookingId, sessionId);
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
