import 'dart:io';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceCheckResult {
  final bool hasClearFace;
  final String message;
  final Face? face;

  FaceCheckResult({
    required this.hasClearFace,
    required this.message,
    this.face,
  });
}

Future<FaceCheckResult> checkImageHasClearFace(
  File imageFile, {
  double minFaceWidth = 100, // px, tune based on your typical image resolution
  double maxHeadEulerAngleY = 25, // left-right rotation tolerance
  double maxHeadEulerAngleZ = 20, // tilt tolerance
  double minEyeOpenProbability = 0.4,
}) async {
  final options = FaceDetectorOptions(
    performanceMode: FaceDetectorMode.accurate,
    enableClassification: true, // needed for eye-open probability
    enableTracking: false,
    minFaceSize: 0.1, // relative to image size
  );

  final faceDetector = FaceDetector(options: options);

  try {
    final inputImage = InputImage.fromFile(imageFile);
    final List<Face> faces = await faceDetector.processImage(inputImage);

    if (faces.isEmpty) {
      return FaceCheckResult(
        hasClearFace: false,
        message: 'No face detected in the image.',
      );
    }

    if (faces.length > 1) {
      return FaceCheckResult(
        hasClearFace: false,
        message:
            'Multiple faces detected (${faces.length}). Expected a single clear face.',
      );
    }

    final face = faces.first;
    final box = face.boundingBox;

    // Check face size — too small usually means face is far away / low detail
    if (box.width < minFaceWidth) {
      return FaceCheckResult(
        hasClearFace: false,
        message: 'Face is too small/far in the image.',
        face: face,
      );
    }

    // Check head rotation (yaw)
    final angleY = face.headEulerAngleY ?? 0;
    if (angleY.abs() > maxHeadEulerAngleY) {
      return FaceCheckResult(
        hasClearFace: false,
        message: 'Face is turned too far to the side.',
        face: face,
      );
    }

    // Check head tilt (roll)
    final angleZ = face.headEulerAngleZ ?? 0;
    if (angleZ.abs() > maxHeadEulerAngleZ) {
      return FaceCheckResult(
        hasClearFace: false,
        message: 'Face is tilted too much.',
        face: face,
      );
    }

    // Check eyes open (if classification is available)
    final leftEyeOpen = face.leftEyeOpenProbability;
    final rightEyeOpen = face.rightEyeOpenProbability;

    if (leftEyeOpen != null && leftEyeOpen < minEyeOpenProbability) {
      return FaceCheckResult(
        hasClearFace: false,
        message: 'Left eye appears closed.',
        face: face,
      );
    }

    if (rightEyeOpen != null && rightEyeOpen < minEyeOpenProbability) {
      return FaceCheckResult(
        hasClearFace: false,
        message: 'Right eye appears closed.',
        face: face,
      );
    }

    return FaceCheckResult(
      hasClearFace: true,
      message: 'Clear face detected.',
      face: face,
    );
  } catch (e) {
    return FaceCheckResult(
      hasClearFace: false,
      message: 'Error processing image: $e',
    );
  } finally {
    faceDetector.close();
  }
}
