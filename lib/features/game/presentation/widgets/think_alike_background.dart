import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class ThinkAlikeBackground extends StatelessWidget {
  const ThinkAlikeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.scaffoldBackground,
            Color.lerp(
              AppColors.scaffoldBackground,
              AppColors.brandBackground,
              0.4,
            )!,
            Color.lerp(
              AppColors.scaffoldBackground,
              AppColors.aiSurfaceBg,
              0.25,
            )!,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}
