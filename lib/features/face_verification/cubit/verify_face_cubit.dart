import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/face_verification/data/face_verify_response.dart';
import 'package:memo/features/face_verification/repository/face_repository.dart';

@injectable
class VerifyFaceCubit extends Cubit<BaseApiState<FaceVerifyResponse>> {
  VerifyFaceCubit(this.faceRepository) : super(const BaseApiState.initial());
  final FaceRepository faceRepository;

  Future<void> verifyFace(File image) async {
    // emit a loading state so listeners always see a state transition
    emit(const BaseApiState.loading());
    final response = await faceRepository.verifyFace(image);

    emit(
      response.fold(
        (l) => l.validationErrorOrNull != null
            ? BaseApiState.validationError(l.validationErrorOrNull!)
            : BaseApiState.error(l.errorMessage),
        (r) {
          return BaseApiState.success(r.data);
        },
      ),
    );
  }
}
