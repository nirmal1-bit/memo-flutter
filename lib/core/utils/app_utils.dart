import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class AppUtils {
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

  // static Future<File?> compressImage(String path) async {
  //   final tempDir = await getTemporaryDirectory();
  //   final targetPath = p.join(
  //     tempDir.path,
  //     '${DateTime.now().microsecondsSinceEpoch}_temp_image.jpg',
  //   );

  //   final originalSize = File(path).lengthSync();
  //   print('Original size: ${originalSize / 1024} KB');

  //   final compressedImage = await FlutterImageCompress.compressAndGetFile(
  //     path,
  //     targetPath,
  //     quality: 20, // good balance for OCR
  //     minWidth: 924, // resizing is key
  //     minHeight: 924,
  //     format: CompressFormat.jpeg,
  //   );
  //   print(" the image is $compressedImage");

  //   if (compressedImage == null) {
  //     AppUtils.showErrorSnackbar(
  //       message: "Some error occurred in image compression",
  //     );
  //     return null;
  //   }
  //   print("The image path is ${compressedImage.path}");

  //   final compressedSize = File(compressedImage.path).lengthSync();
  //   print('Compressed size: ${compressedSize / 1024} KB');

  //   return File(compressedImage.path);
  // }

  // static Future<File> ensureJpgFile(String path) async {
  //   final file = File(path);
  //   final ext = p.extension(path).toLowerCase();

  //   if (ext == '.jpg' || ext == '.jpeg') {
  //     return file;
  //   }

  //   final newPath = p.setExtension(path, '.jpg');
  //   return file.copy(newPath);
  // }
}
