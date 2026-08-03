import 'dart:io';

import 'package:downloadsfolder/downloadsfolder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/services/cloudinary_service.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class AppUtils {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = true,
  }) => showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    backgroundColor: AppColors.transparent,
    builder: builder,
  );

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
      if (context != null && context.mounted) {
        showErrorSnackbar(context: context, message: error.toString());
      }
      return null;
    }
  }

  /// Picks and uploads an image first, then asks the user for its description.
  static Future<({String imageUrl, String description})?>
  pickImageAndDescription({
    required BuildContext context,
    String? folder,
  }) async {
    final imageUrl = await pickAndUploadImage(context: context, folder: folder);
    if (imageUrl == null || imageUrl.isEmpty || !context.mounted) return null;

    final description = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => const _ImageDescriptionSheet(),
    );
    if (description == null || !context.mounted) return null;

    return (imageUrl: imageUrl, description: description);
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

class _ImageDescriptionSheet extends StatefulWidget {
  const _ImageDescriptionSheet();

  @override
  State<_ImageDescriptionSheet> createState() => _ImageDescriptionSheetState();
}

class _ImageDescriptionSheetState extends State<_ImageDescriptionSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Add a picture',
              style: AppTextStyles.rubik.copyWith(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Add a short description for this picture.',
              style: AppTextStyles.rubik.copyWith(
                fontSize: 13,
                color: AppColors.textLightDark,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              autofocus: true,
              maxLines: 4,
              maxLength: 180,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'What makes this moment special?',
                filled: true,
                fillColor: AppColors.lightGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pop(context, _controller.text.trim()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Add picture'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
