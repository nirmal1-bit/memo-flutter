import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/profile/data/request/profile_request_model.dart';
import 'package:memo/features/profile/repository/profile_repository.dart';

@injectable
class EditProfileCubit extends Cubit<BaseApiState<String>> {
  EditProfileCubit(this.profileRepository)
    : super(const BaseApiState.initial());

  final ProfileRepository profileRepository;

  Future<void> editProfile(ProfileRequestModel request) async {
    emit(const BaseApiState.loading());
    final response = await profileRepository.editProfile(request);

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
