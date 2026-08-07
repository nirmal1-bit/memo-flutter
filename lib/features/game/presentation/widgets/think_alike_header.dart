import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/game/presentation/models/think_alike_game_state.dart';

class ThinkAlikeHeader extends StatelessWidget {
  const ThinkAlikeHeader({super.key, required this.gameState});

  final ThinkAlikeGameState gameState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Think Alike',
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHeading,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              _StatusChip(gameState: gameState),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.gameState});

  final ThinkAlikeGameState gameState;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (gameState) {
      ThinkAlikeGameState.waitingForAcceptance => (
        'Waiting',
        AppColors.statusOrange,
      ),
      ThinkAlikeGameState.waitingForAnswers => (
        'In Progress',
        AppColors.primary,
      ),
      ThinkAlikeGameState.readyToReveal => ('Ready!', AppColors.statusGreen),
      ThinkAlikeGameState.completed => ('Completed', AppColors.statusGreen),
      ThinkAlikeGameState.cancelled => ('Cancelled', AppColors.statusRed),
    };
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: AppTextStyles.rubik.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
