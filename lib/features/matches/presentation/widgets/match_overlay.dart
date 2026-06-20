import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/matches/data/models/response/matches_response.dart';

class MatchOverlay extends StatelessWidget {
  const MatchOverlay({
    super.key,
    required this.profile,
    required this.currentUserAvatarUrl,
    required this.onSendMessage,
    required this.onKeepSwiping,
  });

  final MatchesResponse profile;
  final String currentUserAvatarUrl;
  final VoidCallback onSendMessage;
  final VoidCallback onKeepSwiping;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: AppColors.black.withOpacity(0.75),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                      "IT'S A MATCH!",
                      style: AppTextStyles.libre.copyWith(
                        color: AppColors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: -0.3, end: 0),
                const SizedBox(height: 8),
                Text(
                  'You and ${profile.name} liked each other',
                  style: AppTextStyles.rubik.copyWith(
                    color: AppColors.lightWhite,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ).animate(delay: 150.ms).fadeIn(duration: 400.ms),
                const SizedBox(height: 32),
                SizedBox(
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _MatchAvatar(url: currentUserAvatarUrl)
                            .animate()
                            .slideX(
                              begin: -1,
                              end: 0,
                              duration: 500.ms,
                              curve: Curves.easeOutBack,
                            ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _MatchAvatar(url: profile.profileUrl)
                            .animate()
                            .slideX(
                              begin: 1,
                              end: 0,
                              duration: 500.ms,
                              curve: Curves.easeOutBack,
                            ),
                      ),
                      const Icon(
                            Icons.favorite,
                            color: AppColors.buttonPrimary,
                            size: 42,
                          )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .scale(
                            begin: const Offset(0.85, 0.85),
                            end: const Offset(1.15, 1.15),
                            duration: 700.ms,
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSendMessage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimary,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      'Send a Message',
                      style: AppTextStyles.rubik.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.3, end: 0),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: onKeepSwiping,
                  child: Text(
                    'Keep Swiping',
                    style: AppTextStyles.rubik.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ).animate(delay: 400.ms).fadeIn(),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

class _MatchAvatar extends StatelessWidget {
  const _MatchAvatar({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 3),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}
