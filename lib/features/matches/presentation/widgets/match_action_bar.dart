import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:memo/core/constants/app_colors.dart';

class MatchActionBar extends StatelessWidget {
  const MatchActionBar({
    super.key,
    required this.onRewind,
    required this.onNope,
    required this.onLike,
  });

  final VoidCallback onRewind;
  final VoidCallback onNope;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _CircleButton(
                icon: Icons.replay,
                color: AppColors.textGrey,
                size: 46,
                onTap: onRewind,
              ),
              _CircleButton(
                icon: Icons.close,
                color: AppColors.statusRed,
                size: 60,
                onTap: onNope,
              ),
              _CircleButton(
                icon: Icons.favorite,
                color: AppColors.statusGreen,
                size: 60,
                onTap: onLike,
              ),
            ],
          ),
        )
        .animate(delay: 200.ms)
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.4, end: 0, curve: Curves.easeOut);
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.color,
    required this.size,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      shape: const CircleBorder(),
      elevation: 4,
      shadowColor: AppColors.shadow,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Icon(icon, color: color, size: size * 0.45),
          ),
        ),
      ),
    );
  }
}
