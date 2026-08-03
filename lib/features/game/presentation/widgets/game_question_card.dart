import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class GameQuestionCard extends StatefulWidget {
  const GameQuestionCard({
    super.key,
    required this.question,
    this.questionNumber,
    this.totalQuestions,
  });

  final String question;
  final int? questionNumber;
  final int? totalQuestions;

  @override
  State<GameQuestionCard> createState() => _GameQuestionCardState();
}

class _GameQuestionCardState extends State<GameQuestionCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant GameQuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFAF5FF),
                      Color(0xFFF0EAF6),
                      Color(0xFFE8DDEF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.border.withOpacity(0.6),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: AppColors.shadow.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.questionNumber != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Question ${widget.questionNumber}'
                              '${widget.totalQuestions != null ? ' of ${widget.totalQuestions}' : ''}',
                              style: AppTextStyles.rubik.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                    Icon(
                      Icons.format_quote_rounded,
                      color: AppColors.primary.withOpacity(0.3),
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.question,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.libre.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textHeading,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      Icons.format_quote_rounded,
                      color: AppColors.primary.withOpacity(0.3),
                      size: 32,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
