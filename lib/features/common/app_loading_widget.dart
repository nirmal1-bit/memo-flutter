import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:memo/core/constants/app_colors.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    required this.size,
    this.color = AppColors.statusGreen,
  });

  const AppLoadingWidget.small({
    super.key,
    this.size = 36,
    this.color = AppColors.statusGreen,
  });

  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(
        color: AppColors.statusGreen,
        size: size,
      ),
    );
  }
}
