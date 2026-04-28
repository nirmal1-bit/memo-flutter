import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/features/profile/data/request/profile_request_model.dart';

class EditProfileCubit extends Cubit<ProfileRequestModel?> {
  EditProfileCubit() : super(null);

  void setInitialProfile(ProfileRequestModel? profile) {
    emit(profile);
  }
}
