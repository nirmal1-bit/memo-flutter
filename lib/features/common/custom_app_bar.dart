import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: AppColors.softPrimary,
        title: Text(
          title,
          style: AppTextStyles.libre.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.softPrimary,
          ),
        ),
      ),
    );
  }
}
