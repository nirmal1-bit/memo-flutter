import 'dart:io';

import 'package:injectable/injectable.dart';

@injectable
class ImageCaptureState {
  final File? image;

  // defining a factory method

  const ImageCaptureState({this.image});

  ImageCaptureState copyWith({File? image}) {
    return ImageCaptureState(image: image ?? this.image);
  }
}
