import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class GameMatchBadge extends StatefulWidget {
  const GameMatchBadge({
    super.key,
    required this.matchCount,
    required this.totalWords,
    this.delay = Duration.zero,
  });

  final int matchCount;
  final int totalWords;
  final Duration delay;

  @override
  State<GameMatchBadge> createState() => _GameMatchBadgeState();
}

class _GameMatchBadgeState extends State<GameMatchBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _emoji {
    final ratio = widget.totalWords > 0
        ? widget.matchCount / widget.totalWords
        : 0.0;
    if (ratio >= 0.6) return '🎉';
    if (ratio >= 0.3) return '✨';
    if (widget.matchCount > 0) return '💜';
    return '🤔';
  }

  String get _message {
    final ratio = widget.totalWords > 0
        ? widget.matchCount / widget.totalWords
        : 0.0;
    if (ratio >= 0.6) return 'Amazing! You think alike!';
    if (ratio >= 0.3) return 'Great minds overlap!';
    if (widget.matchCount > 0) return 'Some common ground!';
    return 'Different perspectives!';
  }

  Color get _badgeColor {
    if (widget.matchCount >= 3) return AppColors.statusGreen;
    if (widget.matchCount >= 1) return AppColors.statusOrange;
    return AppColors.textCaption;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _badgeColor.withOpacity(0.08),
                    _badgeColor.withOpacity(0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _badgeColor.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_emoji, style: const TextStyle(fontSize: 36)),
                  const SizedBox(height: 8),
                  Text(
                    _message,
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textHeading,
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.matchCount}',
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: _badgeColor,
                          ),
                        ),
                        TextSpan(
                          text: ' matching words',
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 14,
                            color: AppColors.textBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
