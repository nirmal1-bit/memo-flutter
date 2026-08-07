import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/game/presentation/widgets/game_answer_input.dart';
import 'package:memo/features/game/presentation/widgets/game_player_avatar.dart';
import 'package:memo/features/game/presentation/widgets/game_question_card.dart';
import 'package:memo/features/game/presentation/widgets/game_reveal_card.dart';
import 'package:memo/features/game/presentation/widgets/pulsing_dot_indicator.dart';
import 'package:memo/features/game/presentation/widgets/think_alike_action_button.dart';
import 'package:memo/features/game/presentation/widgets/think_alike_player_row.dart';

class ThinkAlikeWaitingForAcceptance extends StatelessWidget {
  const ThinkAlikeWaitingForAcceptance({
    super.key,
    required this.initiatorName,
    required this.partnerName,
    required this.waitDots,
    required this.onAccept,
    required this.onCancel,
    this.acceptLabel = 'Accept Game',
    this.cancelLabel = 'Cancel Invite',
    required this.isFromPartner,
    this.userProfileUrl,
    this.partnerProfileUrl,
  });
  final String initiatorName;
  final String partnerName;
  final int waitDots;
  final VoidCallback onAccept;
  final VoidCallback onCancel;
  final String acceptLabel;
  final String cancelLabel;
  final bool isFromPartner;
  final String? userProfileUrl;
  final String? partnerProfileUrl;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 40),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutBack,
            builder: (_, value, child) => Transform.scale(
              scale: 0.5 + 0.5 * value,
              child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
            ),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.buttonPrimary],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.mail_outline_rounded,
                size: 48,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            isFromPartner ? 'Game Invitation!' : 'Invite Sent!',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.textHeading,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isFromPartner
                ? '$initiatorName invited you to play${'.' * waitDots}'
                : 'Waiting for $partnerName to accept${'.' * waitDots}',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 15,
              color: AppColors.textBody,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          ThinkAlikePlayerRow(
            initiatorName: initiatorName,
            partnerName: partnerName,
            initiatorStatus: 'Ready',
            partnerStatus: 'Pending',
            showConnector: true,
            userProfileUrl: userProfileUrl,
            partnerProfileUrl: partnerProfileUrl,
          ),
          const SizedBox(height: 40),
          PulsingDotIndicator(color: AppColors.primary.withOpacity(0.6)),
          const SizedBox(height: 40),
          if (isFromPartner)
            ThinkAlikeActionButton(
              label: acceptLabel,
              icon: Icons.play_arrow_rounded,
              onTap: onAccept,
              isPrimary: true,
            ),
          const SizedBox(height: 12),
          ThinkAlikeActionButton(
            label: cancelLabel,
            icon: Icons.close_rounded,
            onTap: onCancel,
            isPrimary: false,
          ),
        ],
      ),
    );
  }
}

class ThinkAlikeWaitingForAnswers extends StatelessWidget {
  const ThinkAlikeWaitingForAnswers({
    super.key,
    required this.initiatorName,
    required this.partnerName,
    required this.question,
    required this.myAnswerSubmitted,
    required this.partnerAnswerSubmitted,
    required this.controller,
    required this.onSubmit,
    this.userProfileUrl,
    this.partnerProfileUrl,
  });
  final String initiatorName;
  final String partnerName;
  final String question;
  final bool myAnswerSubmitted;
  final bool partnerAnswerSubmitted;
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final String? userProfileUrl;
  final String? partnerProfileUrl;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        const SizedBox(height: 8),
        ThinkAlikePlayerRow(
          initiatorName: initiatorName,
          partnerName: partnerName,
          showConnector: false,
          initiatorStatus: myAnswerSubmitted ? 'Done ✓' : 'Typing...',
          partnerStatus: partnerAnswerSubmitted ? 'Answered ✓' : 'Thinking...',
          userProfileUrl: userProfileUrl,
          partnerProfileUrl: partnerProfileUrl,
        ),
        const SizedBox(height: 24),
        GameQuestionCard(
          question: question,
          questionNumber: 1,
          totalQuestions: 5,
        ),
        const SizedBox(height: 28),
        GameAnswerInput(
          controller: controller,
          onSubmit: onSubmit,
          isSubmitted: myAnswerSubmitted,
          hintText: 'Share your answer privately...',
        ),
        if (partnerAnswerSubmitted && !myAnswerSubmitted) ...[
          const SizedBox(height: 16),
          const _PartnerAnsweredBanner(),
        ],
        if (myAnswerSubmitted && !partnerAnswerSubmitted) ...[
          const SizedBox(height: 20),
          _PartnerWaitingIndicator(
            partnerName: partnerName,
            profileUrl: partnerProfileUrl,
          ),
        ],
      ],
    ),
  );
}

class _PartnerAnsweredBanner extends StatelessWidget {
  const _PartnerAnsweredBanner();

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
    decoration: BoxDecoration(
      color: AppColors.primary.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Your partner already answered. Submit your answer to reveal both!',
            style: AppTextStyles.rubik.copyWith(
              color: AppColors.textDark,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

class _PartnerWaitingIndicator extends StatelessWidget {
  const _PartnerWaitingIndicator({required this.partnerName, this.profileUrl});
  final String partnerName;
  final String? profileUrl;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(milliseconds: 600),
    curve: Curves.easeOut,
    builder: (_, value, child) => Opacity(
      opacity: value,
      child: Transform.translate(
        offset: Offset(0, 20 * (1 - value)),
        child: child,
      ),
    ),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.brandBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GamePlayerAvatar(
            name: partnerName,
            imageUrl: profileUrl,
            size: 36,
            showGlow: true,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$partnerName is typing...',
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                const PulsingDotIndicator(color: AppColors.primary, size: 6),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class ThinkAlikeReadyToReveal extends StatelessWidget {
  const ThinkAlikeReadyToReveal({
    super.key,
    required this.initiatorName,
    required this.partnerName,
    required this.question,
    required this.onReveal,
    this.userProfileUrl,
    this.partnerProfileUrl,
  });
  final String initiatorName;
  final String partnerName;
  final String question;
  final VoidCallback onReveal;
  final String? userProfileUrl;
  final String? partnerProfileUrl;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        const SizedBox(height: 8),
        ThinkAlikePlayerRow(
          initiatorName: initiatorName,
          partnerName: partnerName,
          showConnector: false,
          initiatorStatus: 'Ready ✓',
          partnerStatus: 'Ready ✓',
          userProfileUrl: userProfileUrl,
          partnerProfileUrl: partnerProfileUrl,
        ),
        const SizedBox(height: 24),
        GameQuestionCard(
          question: question,
          questionNumber: 1,
          totalQuestions: 5,
        ),
        const SizedBox(height: 32),
        _RevealButton(onTap: onReveal),
        const SizedBox(height: 20),
        Text(
          'Both answers are in! 🎯',
          style: AppTextStyles.rubik.copyWith(
            fontSize: 15,
            color: AppColors.textBody,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Tap to see if you think alike',
          style: AppTextStyles.rubik.copyWith(
            fontSize: 13,
            color: AppColors.textCaption,
          ),
        ),
      ],
    ),
  );
}

class _RevealButton extends StatelessWidget {
  const _RevealButton({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.buttonPrimary,
                AppColors.secondary,
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.visibility_rounded,
                color: AppColors.white.withOpacity(0.9),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Reveal Answers',
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThinkAlikeCompleted extends StatelessWidget {
  const ThinkAlikeCompleted({
    super.key,
    required this.question,
    required this.initiatorName,
    required this.partnerName,
    required this.initiatorAnswer,
    required this.partnerAnswer,
    required this.onPlayAgain,
  });
  final String question;
  final String initiatorName;
  final String partnerName;
  final String initiatorAnswer;
  final String partnerAnswer;
  final VoidCallback onPlayAgain;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        const SizedBox(height: 8),
        GameQuestionCard(
          question: question,
          questionNumber: 1,
          totalQuestions: 5,
        ),
        const SizedBox(height: 28),
        Text(
          initiatorAnswer.trim().toLowerCase() ==
                  partnerAnswer.trim().toLowerCase()
              ? 'You think alike!'
              : 'Different answers',
          style: AppTextStyles.rubik.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color:
                initiatorAnswer.trim().toLowerCase() ==
                    partnerAnswer.trim().toLowerCase()
                ? AppColors.statusGreen
                : AppColors.textBody,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GameRevealCard(
                playerName: initiatorName,
                answer: initiatorAnswer,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GameRevealCard(
                playerName: partnerName,
                answer: partnerAnswer,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        ThinkAlikeActionButton(
          label: 'Play Again',
          icon: Icons.replay_rounded,
          onTap: onPlayAgain,
          isPrimary: true,
        ),
        const SizedBox(height: 12),
        const ThinkAlikeActionButton(
          label: 'Share Result',
          icon: Icons.share_rounded,
          onTap: _noop,
          isPrimary: false,
        ),
      ],
    ),
  );
  static void _noop() {}
}

class _MatchingWords extends StatelessWidget {
  const _MatchingWords({required this.words});
  final List<String> words;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (_, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: child,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Matching Words',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textCaption,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: words.map((word) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.highlightYellow.withOpacity(0.8),
                      AppColors.highlightYellow,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.yellow.withOpacity(0.5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.yellow.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  word,
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ThinkAlikeCancelled extends StatelessWidget {
  const ThinkAlikeCancelled({super.key, required this.onStartNewGame});
  final VoidCallback onStartNewGame;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutBack,
            builder: (_, value, child) => Transform.scale(
              scale: 0.5 + 0.5 * value,
              child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.statusLightRed,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.statusRed.withOpacity(0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.sentiment_dissatisfied_rounded,
                size: 44,
                color: AppColors.statusRed,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Game Cancelled',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textHeading,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'The game was ended before completion.\nDon\'t worry — you can start a new round!',
            textAlign: TextAlign.center,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 14,
              color: AppColors.textBody,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 36),
          ThinkAlikeActionButton(
            label: 'Start New Game',
            icon: Icons.refresh_rounded,
            onTap: onStartNewGame,
            isPrimary: true,
          ),
        ],
      ),
    ),
  );
}
