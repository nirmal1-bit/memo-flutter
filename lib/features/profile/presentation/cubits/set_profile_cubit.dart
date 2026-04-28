import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/profile/data/request/profile_request_model.dart';
import 'package:memo/features/profile/repository/profile_repository.dart';

@injectable
class SetProfileCubit extends Cubit<BaseApiState<String>> {
  SetProfileCubit(this.profileRepository) : super(const BaseApiState.initial());

  final ProfileRepository profileRepository;

  Future<void> setupProfile(ProfileRequestModel request) async {
    emit(const BaseApiState.loading());
    final response = await profileRepository.setupProfile(request);

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
