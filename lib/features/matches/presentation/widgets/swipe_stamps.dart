import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/matches/presentation/widgets/swipe_stamp_badge.dart';

class SwipeStamps extends StatelessWidget {
  const SwipeStamps({
    super.key,
    required this.dragOffset,
    required this.swipeThreshold,
  });

  final Offset dragOffset;
  final double swipeThreshold;

  @override
  Widget build(BuildContext context) {
    final likeOpacity = (dragOffset.dx / swipeThreshold).clamp(0.0, 1.0);
    final nopeOpacity = (-dragOffset.dx / swipeThreshold).clamp(0.0, 1.0);

    return Stack(
      children: [
        Positioned(
          top: 40,
          left: 24,
          child: Opacity(
            opacity: likeOpacity,
            child: Transform.rotate(
              angle: -0.35,
              child: const SwipeStampBadge(
                label: 'LIKE',
                color: AppColors.statusGreen,
              ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 24,
          child: Opacity(
            opacity: nopeOpacity,
            child: Transform.rotate(
              angle: 0.35,
              child: const SwipeStampBadge(
                label: 'NOPE',
                color: AppColors.statusRed,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
