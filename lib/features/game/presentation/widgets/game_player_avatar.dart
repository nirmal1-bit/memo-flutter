import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class GamePlayerAvatar extends StatefulWidget {
  const GamePlayerAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.size = 56,
    this.showGlow = false,
    this.isActive = true,
    this.glowColor,
  });

  final String name;
  final String? imageUrl;
  final double size;
  final bool showGlow;
  final bool isActive;
  final Color? glowColor;

  @override
  State<GamePlayerAvatar> createState() => _GamePlayerAvatarState();
}

class _GamePlayerAvatarState extends State<GamePlayerAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    if (widget.showGlow) {
      _glowController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant GamePlayerAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showGlow && !_glowController.isAnimating) {
      _glowController.repeat(reverse: true);
    } else if (!widget.showGlow && _glowController.isAnimating) {
      _glowController.stop();
      _glowController.value = 0.3;
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  String get _initials {
    final name = widget.name.trim();
    if (name.isEmpty) return '?';
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final glowColor = widget.glowColor ?? AppColors.primary;
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (_, child) {
        return Container(
          width: widget.size + 12,
          height: widget.size + 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: widget.showGlow
                ? [
                    BoxShadow(
                      color: glowColor.withOpacity(0.35 * _glowAnimation.value),
                      blurRadius: 16 * _glowAnimation.value,
                      spreadRadius: 2 * _glowAnimation.value,
                    ),
                  ]
                : null,
          ),
          child: child,
        );
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.buttonPrimary],
          ),
          border: Border.all(color: AppColors.white, width: 2.5),
        ),
        child: ClipOval(
          child: widget.imageUrl == null || widget.imageUrl!.trim().isEmpty
              ? _Initials(name: _initials, size: widget.size)
              : Image.network(
                  widget.imageUrl!,
                  width: widget.size,
                  height: widget.size,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      _Initials(name: _initials, size: widget.size),
                ),
        ),
      ),
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({required this.name, required this.size});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        name,
        style: AppTextStyles.rubik.copyWith(
          fontSize: size * 0.35,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
