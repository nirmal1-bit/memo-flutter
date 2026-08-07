import 'package:flutter/material.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/game/data/think_alike_models.dart';
import 'package:memo/features/game/presentation/models/think_alike_game_state.dart';
import 'package:memo/features/game/presentation/widgets/think_alike_state_views.dart';

class ThinkAlikeStateContent extends StatelessWidget {
  const ThinkAlikeStateContent({
    super.key,
    required this.session,
    required this.gameState,
    required this.requestFailed,
    required this.sessionId,
    required this.initiatorName,
    required this.partnerName,
    required this.question,
    required this.initiatorAnswer,
    required this.partnerAnswer,
    required this.answerController,
    required this.myAnswerSubmitted,
    required this.partnerAnswerSubmitted,
    required this.onRetry,
    required this.onAccept,
    required this.onCancel,
    required this.onSubmitAnswer,
    required this.onReveal,
    required this.onPlayAgain,
    this.acceptLabel = 'Accept Game',
    this.cancelLabel = 'Cancel Invite',
    this.isFromPatner = false,
    this.userProfileUrl,
    this.partnerProfileUrl,
  });

  final ThinkAlikeSession? session;
  final ThinkAlikeGameState gameState;
  final bool requestFailed;
  final int? sessionId;
  final String initiatorName;
  final String partnerName;
  final String question;
  final String initiatorAnswer;
  final String partnerAnswer;
  final TextEditingController answerController;
  final bool myAnswerSubmitted;
  final bool partnerAnswerSubmitted;
  final VoidCallback onRetry;
  final VoidCallback onAccept;
  final VoidCallback onCancel;
  final VoidCallback onSubmitAnswer;
  final VoidCallback onReveal;
  final VoidCallback onPlayAgain;
  final String acceptLabel;
  final String cancelLabel;
  final bool isFromPatner;
  final String? userProfileUrl;
  final String? partnerProfileUrl;

  @override
  Widget build(BuildContext context) {
    if (session == null) {
      return Center(
        key: const ValueKey('loading-game'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            Text(
              requestFailed
                  ? 'Unable to load this game session'
                  : sessionId == null
                  ? 'Waiting for a game session'
                  : 'Loading game...',
              style: AppTextStyles.rubik.copyWith(
                color: AppColors.textBody,
                fontSize: 14,
              ),
            ),
            if (requestFailed) ...[
              const SizedBox(height: 16),
              TextButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ],
        ),
      );
    }

    return switch (gameState) {
      ThinkAlikeGameState.waitingForAcceptance =>
        ThinkAlikeWaitingForAcceptance(
          key: const ValueKey('waiting'),
          initiatorName: initiatorName,
          partnerName: partnerName,
          waitDots: 0,
          onAccept: onAccept,
          onCancel: onCancel,
          acceptLabel: acceptLabel,
          cancelLabel: cancelLabel,
          isFromPartner: isFromPatner,
          userProfileUrl: userProfileUrl,
          partnerProfileUrl: partnerProfileUrl,
        ),
      ThinkAlikeGameState.waitingForAnswers => ThinkAlikeWaitingForAnswers(
        key: const ValueKey('answers'),
        initiatorName: initiatorName,
        partnerName: partnerName,
        question: question,
        myAnswerSubmitted: myAnswerSubmitted,
        partnerAnswerSubmitted: partnerAnswerSubmitted,
        controller: answerController,
        onSubmit: onSubmitAnswer,
        userProfileUrl: userProfileUrl,
        partnerProfileUrl: partnerProfileUrl,
      ),
      ThinkAlikeGameState.readyToReveal => ThinkAlikeReadyToReveal(
        key: const ValueKey('reveal'),
        initiatorName: initiatorName,
        partnerName: partnerName,
        question: question,
        onReveal: onReveal,
        userProfileUrl: userProfileUrl,
        partnerProfileUrl: partnerProfileUrl,
      ),
      ThinkAlikeGameState.completed => ThinkAlikeCompleted(
        key: const ValueKey('completed'),
        question: question,
        initiatorName: initiatorName,
        partnerName: partnerName,
        initiatorAnswer: initiatorAnswer,
        partnerAnswer: partnerAnswer,
        onPlayAgain: onPlayAgain,
      ),
      ThinkAlikeGameState.cancelled => ThinkAlikeCancelled(
        key: const ValueKey('cancelled'),
        onStartNewGame: onPlayAgain,
      ),
    };
  }
}
