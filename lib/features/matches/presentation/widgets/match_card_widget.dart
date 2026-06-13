import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/constants/app_text_styles.dart';
import 'match_card_data.dart';
import 'match_action_buttons.dart';
import 'match_card_info_overlay.dart';
import 'match_card_swipe_indicator.dart';

class MatchCardWidget extends StatefulWidget {
  final MatchCardData data;
  final VoidCallback? onLike;
  final VoidCallback? onDislike;
  final VoidCallback? onSuperLike;

  const MatchCardWidget({
    super.key,
    required this.data,
    this.onLike,
    this.onDislike,
    this.onSuperLike,
  });

  @override
  State<MatchCardWidget> createState() => _MatchCardWidgetState();
}

class _MatchCardWidgetState extends State<MatchCardWidget>
    with SingleTickerProviderStateMixin {
  Offset _dragOffset = Offset.zero;
  double _rotation = 0;
  bool _isDragging = false;

  SwipeDirection get _swipeDirection {
    if (_dragOffset.dx > 60) return SwipeDirection.right;
    if (_dragOffset.dx < -60) return SwipeDirection.left;
    if (_dragOffset.dy < -60) return SwipeDirection.up;
    return SwipeDirection.none;
  }

  void _onPanStart(DragStartDetails _) {
    setState(() => _isDragging = true);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
      _rotation = _dragOffset.dx * 0.0015;
    });
  }

  void _onPanEnd(DragEndDetails _) {
    final dir = _swipeDirection;
    if (dir == SwipeDirection.right) {
      widget.onLike?.call();
    } else if (dir == SwipeDirection.left) {
      widget.onDislike?.call();
    } else if (dir == SwipeDirection.up) {
      widget.onSuperLike?.call();
    }
    setState(() {
      _dragOffset = Offset.zero;
      _rotation = 0;
      _isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child:
          Transform.translate(
                offset: _dragOffset,
                child: Transform.rotate(angle: _rotation, child: _buildCard()),
              )
              .animate()
              .fadeIn(duration: 400.ms, curve: Curves.easeOut)
              .slideY(
                begin: 0.08,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOut,
              ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.18),
            blurRadius: 28,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            _CardBackground(imageUrl: widget.data.avatarUrl),

            // Gradient overlay
            const _CardGradientOverlay(),

            // Swipe indicators
            if (_isDragging) ...[
              MatchCardSwipeIndicator(
                direction: _swipeDirection,
                opacity: (_dragOffset.dx.abs() / 120).clamp(0, 1),
              ),
            ],

            // Info overlay at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: MatchCardInfoOverlay(data: widget.data),
            ),

            // Action buttons
            Positioned(
              left: 0,
              right: 0,
              bottom: 80,
              child: MatchActionButtons(
                onLike: widget.onLike,
                onDislike: widget.onDislike,
                onSuperLike: widget.onSuperLike,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardBackground extends StatelessWidget {
  final String imageUrl;
  const _CardBackground({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => Container(
        color: AppColors.brandBackground,
        child: const Icon(Icons.person, size: 100, color: AppColors.primary),
      ),
      loadingBuilder: (_, child, progress) {
        if (progress == null) return child;
        return Container(
          color: AppColors.lightGrey,
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        );
      },
    );
  }
}

class _CardGradientOverlay extends StatelessWidget {
  const _CardGradientOverlay();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.4, 1.0],
          colors: [
            AppColors.transparent,
            AppColors.transparent,
            AppColors.black.withOpacity(0.85),
          ],
        ),
      ),
    );
  }
}
