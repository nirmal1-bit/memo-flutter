import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/auth/domain/repository/auth_repository.dart';

@injectable
class VerifyTokenCubit extends Cubit<BaseApiState<String>> {
  VerifyTokenCubit(this.authRepository) : super(const BaseApiState.initial());
  final AuthRepository authRepository;

  Future<void> verifyToken(String otp) async {
    // emit a loading state so listeners always see a state transition
    emit(const BaseApiState.loading());
    final response = await authRepository.verifyToken(otp);

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

  Future<void> verifyTokenForgetPassword(String otp) async {
    // emit a loading state so listeners always see a state transition
    emit(const BaseApiState.loading());
    final response = await authRepository.verifyTokenForgetPassword(otp);

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
