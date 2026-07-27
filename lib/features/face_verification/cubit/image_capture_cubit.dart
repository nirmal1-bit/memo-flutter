import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/features/face_verification/cubit/image_capture_state.dart';

@injectable
class ImageCaptureCubit extends Cubit<ImageCaptureState> {
  ImageCaptureCubit() : super(ImageCaptureState());
  // assigning initial state to the cubit

  void setImage(File image) {
    emit(state.copyWith(image: image));
  }

  void removeImage() {
    emit(state.copyWith(image: null));
  }
}
