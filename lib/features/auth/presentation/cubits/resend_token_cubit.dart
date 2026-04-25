import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/auth/domain/repository/auth_repository.dart';

@injectable
class ResendTokenCubit extends Cubit<BaseApiState<String>> {
  ResendTokenCubit(this.authRepository) : super(const BaseApiState.initial());
  final AuthRepository authRepository;

  Future<void> resendToken(String email) async {
    // emit a loading state so listeners always see a state transition
    emit(const BaseApiState.loading());
    final response = await authRepository.resendToken(email);

    emit(
      response.fold(
        (l) => l.validationErrorOrNull != null
            ? BaseApiState.validationError(l.validationErrorOrNull!)
            : BaseApiState.error(l.errorMessage),
        (r) {
          return BaseApiState.success("success");
        },
      ),
    );
  }

  Future<void> requestToken(String email) async {
    // emit a loading state so listeners always see a state transition
    emit(const BaseApiState.loading());
    final response = await authRepository.requestToken(email);

    emit(
      response.fold(
        (l) => l.validationErrorOrNull != null
            ? BaseApiState.validationError(l.validationErrorOrNull!)
            : BaseApiState.error(l.errorMessage),
        (r) {
          return BaseApiState.success("success");
        },
      ),
    );
  }
}
