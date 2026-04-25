import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    required this.size,
    this.color = AppColors.primary,
  });

  const AppLoadingWidget.small({
    super.key,
    this.size = 36,
    this.color = AppColors.primary,
  });

  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(
        color: AppColors.primary,
        size: size,
      ),
    );
  }
}
