import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/home/domain/repository/connections_repository.dart';

@injectable
class ConnectionActionCubit extends Cubit<BaseApiState<String>> {
  ConnectionActionCubit(this.networkRepository)
    : super(const BaseApiState.initial());

  final ConnectionsRepository networkRepository;

  Future<void> sendConnectionRequest(int userId) async {
    emit(const BaseApiState.loading());
    final response = await networkRepository.sendConnectionRequest(userId);
    emit(
      response.fold(
        (l) => l.validationErrorOrNull != null
            ? BaseApiState.validationError(l.validationErrorOrNull!)
            : BaseApiState.error(l.errorMessage),
        (r) => BaseApiState.success(r.data),
      ),
    );
  }

  Future<void> acceptConnectionRequest(int requestId) async {
    emit(const BaseApiState.loading());
    final response = await networkRepository.acceptConnectionRequest(requestId);
    emit(
      response.fold(
        (l) => l.validationErrorOrNull != null
            ? BaseApiState.validationError(l.validationErrorOrNull!)
            : BaseApiState.error(l.errorMessage),
        (r) => BaseApiState.success(r.data),
      ),
    );
  }

  Future<void> rejectConnectionRequest(int requestId) async {
    emit(const BaseApiState.loading());
    final response = await networkRepository.rejectConnectionRequest(requestId);
    emit(
      response.fold(
        (l) => l.validationErrorOrNull != null
            ? BaseApiState.validationError(l.validationErrorOrNull!)
            : BaseApiState.error(l.errorMessage),
        (r) => BaseApiState.success(r.data),
      ),
    );
  }

  Future<void> cancelConnectionRequest(int requestId) async {
    emit(const BaseApiState.loading());
    final response = await networkRepository.cancelConnectionRequest(requestId);
    emit(
      response.fold(
        (l) => l.validationErrorOrNull != null
            ? BaseApiState.validationError(l.validationErrorOrNull!)
            : BaseApiState.error(l.errorMessage),
        (r) => BaseApiState.success(r.data),
      ),
    );
  }
}
