import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/auth/data/models/request/new_password_request.dart';
import 'package:memo/features/auth/domain/repository/auth_repository.dart';

@injectable
class NewPasswordCubit extends Cubit<BaseApiState<String>> {
  NewPasswordCubit(this.authRepository) : super(const BaseApiState.initial());
  final AuthRepository authRepository;

  Future<void> makeNewPassword(NewPasswordRequest request) async {
    emit(const BaseApiState.loading());
    final response = await authRepository.makeNewPassword(request);

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
