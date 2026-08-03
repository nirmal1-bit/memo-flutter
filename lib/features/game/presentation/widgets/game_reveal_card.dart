import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class GameRevealCard extends StatefulWidget {
  const GameRevealCard({
    super.key,
    required this.playerName,
    required this.answer,
    required this.matchingWords,
    this.isLeft = true,
    this.delay = Duration.zero,
  });

  final String playerName;
  final String answer;
  final List<String> matchingWords;
  final bool isLeft;
  final Duration delay;

  @override
  State<GameRevealCard> createState() => _GameRevealCardState();
}

class _GameRevealCardState extends State<GameRevealCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _flipAnimation;
  late final Animation<double> _fadeAnimation;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _flipAnimation = Tween<double>(
      begin: math.pi / 2,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _showAnswer = true);
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildHighlightedAnswer() {
    final words = widget.answer.split(' ');
    final lowerMatches = widget.matchingWords
        .map((w) => w.toLowerCase())
        .toSet();

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: words.map((word) {
          final isMatch = lowerMatches.contains(word.toLowerCase());
          return TextSpan(
            text: '$word ',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 15,
              fontWeight: isMatch ? FontWeight.w700 : FontWeight.w400,
              color: isMatch ? AppColors.primary : AppColors.textBody,
              backgroundColor: isMatch
                  ? AppColors.highlightYellow.withOpacity(0.8)
                  : null,
              height: 1.6,
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(
              widget.isLeft ? _flipAnimation.value : -_flipAnimation.value,
            ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.border.withOpacity(0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.1),
                          AppColors.buttonPrimary.withOpacity(0.08),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.playerName,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _showAnswer ? _buildHighlightedAnswer() : const SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
