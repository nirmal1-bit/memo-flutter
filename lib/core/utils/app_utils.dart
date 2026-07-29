import 'dart:io';

import 'package:downloadsfolder/downloadsfolder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/services/cloudinary_service.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class AppUtils {
  static final ImagePicker _imagePicker = ImagePicker();

  static void unfocusKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static void confirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
                onConfirm();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static void showErrorSnackbar({
    String message = 'Invalid Url',
    void Function()? onRetry,
    String buttonText = 'Retry',
    BuildContext? context,
  }) {
    if (context != null) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: message,
          backgroundColor: AppColors.statusRed,
          textStyle: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      );
      return;
    }
  }

  static void showSuccessSnackbar({
    String message = 'Success',
    void Function()? onAction,
    String actionText = 'OK',
    BuildContext? context,
  }) {
    if (context != null) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message,
          backgroundColor: AppColors.statusGreen,
          textStyle: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      );
      return;
    }
  }

  static Future<XFile?> pickImage({ImageSource source = ImageSource.gallery}) {
    return _imagePicker.pickImage(source: source, imageQuality: 60);
  }

  static Future<String?> uploadImage({required XFile file, String? folder}) {
    return getIt<CloudinaryService>().uploadImage(file, folder: folder);
  }

  static Future<String?> pickAndUploadImage({
    BuildContext? context,
    ImageSource source = ImageSource.gallery,
    String? folder,
  }) async {
    final pickedFile = await pickImage(source: source);
    if (pickedFile == null) {
      return null;
    }

    try {
      return await uploadImage(file: pickedFile, folder: folder);
    } catch (error) {
      if (context != null) {
        showErrorSnackbar(context: context, message: error.toString());
      }
      return null;
    }
  }

  static Future<void> downloadPdf(String tempFile) async {
    try {
      Directory downloadDirectory = await getDownloadDirectory();
      print('Downloads folder path: ${downloadDirectory.path}');
    } catch (e) {
      print('Failed to retrieve downloads folder path $e');
    }

    bool? success = await copyFileIntoDownloadFolder(tempFile, "Notes");
    if (success == true) {
      print('File copied successfully.');
    } else {
      print('Failed to copy file.');
    }
    AppUtils.showSuccessSnackbar(message: 'PDF downloaded to download folder');
  }
}
