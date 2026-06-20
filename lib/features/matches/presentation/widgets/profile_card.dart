// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/matches/data/models/response/matches_response.dart';
import 'package:memo/features/matches/presentation/widgets/profile_tag_chip.dart';
import 'package:memo/features/matches/presentation/widgets/similarity_badge.dart';
import 'package:memo/features/matches/presentation/widgets/swipe_stamps.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.profile,
    required this.stackIndex,
    required this.isTop,
    required this.constraints,
    required this.dragOffset,
    required this.swipeThreshold,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
  });

  final MatchesResponse profile;
  final int stackIndex;
  final bool isTop;
  final BoxConstraints constraints;
  final Offset dragOffset;
  final double swipeThreshold;
  final GestureDragStartCallback onPanStart;
  final GestureDragUpdateCallback onPanUpdate;
  final GestureDragEndCallback onPanEnd;

  @override
  Widget build(BuildContext context) {
    final scale = 1 - (stackIndex * 0.04);
    final verticalOffset = stackIndex * 14.0;
    final blur = (isTop && dragOffset != Offset.zero) ? 28.0 : 18.0;
    final shadowOffsetY = (isTop && dragOffset != Offset.zero) ? 16.0 : 10.0;

    final card = Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: blur,
            offset: Offset(0, shadowOffsetY),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            profile.profileUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                color: AppColors.lightGrey,
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              );
            },
            errorBuilder: (context, error, stack) => Container(
              color: AppColors.lightGrey,
              child: const Center(
                child: Icon(Icons.person, size: 80, color: AppColors.textLight),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _ProfileCardInfo(profile: profile),
          ),
          Positioned(
            top: 10,
            right: 0,
            child: SizedBox(
              height: 40,
              child: SimilarityBadge(score: profile.similarity),
            ),
          ),
          if (isTop)
            SwipeStamps(dragOffset: dragOffset, swipeThreshold: swipeThreshold),
        ],
      ),
    );

    if (!isTop) {
      return Transform.translate(
        offset: Offset(0, -verticalOffset),
        child: Transform.scale(scale: scale, child: card)
            .animate()
            .fadeIn(duration: 300.ms)
            .scale(begin: const Offset(0.95, 0.95)),
      );
    }

    final angle = dragOffset.dx / 800;
    return Transform.translate(
      offset: dragOffset,
      child: Transform.rotate(
        angle: angle,
        child: GestureDetector(
          onPanStart: onPanStart,
          onPanUpdate: onPanUpdate,
          onPanEnd: onPanEnd,
          child: card,
        ),
      ),
    );
  }
}

class _ProfileCardInfo extends StatelessWidget {
  const _ProfileCardInfo({required this.profile});

  final MatchesResponse profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.transparent, AppColors.black.withOpacity(0.75)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                profile.name,
                style: AppTextStyles.libre.copyWith(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${profile.age}',
                style: AppTextStyles.rubik.copyWith(
                  color: AppColors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.work_outline, size: 14, color: AppColors.white),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  profile.headline,
                  style: AppTextStyles.rubik.copyWith(
                    color: AppColors.lightWhite,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 14,
                color: AppColors.white,
              ),
              const SizedBox(width: 4),
              Text(
                profile.location,
                style: AppTextStyles.rubik.copyWith(
                  color: AppColors.lightWhite,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            profile.bio,
            style: AppTextStyles.rubik.copyWith(
              color: AppColors.white,
              fontSize: 13,
              height: 1.35,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: profile.interests
                .map((tag) => ProfileTagChip(label: tag))
                .toList(),
          ),
        ],
      ),
    );
  }
}
