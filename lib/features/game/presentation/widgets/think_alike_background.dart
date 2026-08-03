import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class ThinkAlikeBackground extends StatelessWidget {
  const ThinkAlikeBackground({super.key, required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, _) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.scaffoldBackground,
              Color.lerp(
                AppColors.scaffoldBackground,
                AppColors.brandBackground,
                0.3 + animation.value * 0.2,
              )!,
              Color.lerp(
                AppColors.scaffoldBackground,
                AppColors.aiSurfaceBg,
                0.2 + animation.value * 0.15,
              )!,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }
}
