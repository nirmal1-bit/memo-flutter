import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/constants/cloudinary_constants.dart';

@lazySingleton
class CloudinaryService {
  CloudinaryService()
    : _dio = Dio(
        BaseOptions(
          receiveTimeout: const Duration(minutes: 2),
          connectTimeout: const Duration(seconds: 60),
          responseType: ResponseType.json,
          headers: const <String, dynamic>{'Accept': 'application/json'},
        ),
      );

  final Dio _dio;

  Future<String> uploadImage(XFile file, {String? folder}) async {
    _validateConfiguration();

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: file.name),
      'upload_preset': CloudinaryConstants.uploadPreset,
      if (folder != null && folder.isNotEmpty) 'folder': folder,
    });

    final response = await _dio.post(
      CloudinaryConstants.uploadUrl(),
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    final data = response.data;
    final secureUrl = data is Map<String, dynamic>
        ? (data['secure_url'] ?? data['url'])?.toString()
        : null;

    if (secureUrl == null || secureUrl.isEmpty) {
      throw StateError('Cloudinary upload completed without a url.');
    }

    return secureUrl;
  }

  void _validateConfiguration() {
    if (CloudinaryConstants.cloudName.isEmpty ||
        CloudinaryConstants.cloudName == 'YOUR_CLOUD_NAME' ||
        CloudinaryConstants.uploadPreset.isEmpty ||
        CloudinaryConstants.uploadPreset == 'YOUR_UNSIGNED_UPLOAD_PRESET') {
      throw StateError(
        'Cloudinary is not configured. Set CLOUDINARY_CLOUD_NAME and '
        'CLOUDINARY_UPLOAD_PRESET before uploading images.',
      );
    }
  }
}
