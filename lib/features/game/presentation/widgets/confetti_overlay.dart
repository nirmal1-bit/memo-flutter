import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class ConfettiOverlay extends StatefulWidget {
  const ConfettiOverlay({super.key, this.particleCount = 40});

  final int particleCount;

  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_ConfettiParticle> _particles;
  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _particles = List.generate(widget.particleCount, (_) {
      return _ConfettiParticle(
        x: _random.nextDouble(),
        delay: _random.nextDouble() * 0.4,
        speed: 0.5 + _random.nextDouble() * 0.5,
        size: 4 + _random.nextDouble() * 6,
        color: _confettiColors[_random.nextInt(_confettiColors.length)],
        wobble: _random.nextDouble() * 2 * math.pi,
        wobbleSpeed: 1 + _random.nextDouble() * 3,
      );
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static final _confettiColors = [
    AppColors.primary,
    AppColors.statusGreen,
    AppColors.yellow,
    AppColors.statusOrange,
    AppColors.accentRose,
    AppColors.secondary2,
    const Color(0xFF6DD5FA),
    const Color(0xFFFF6B9D),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return IgnorePointer(
          child: CustomPaint(
            size: Size.infinite,
            painter: _ConfettiPainter(
              particles: _particles,
              progress: _controller.value,
            ),
          ),
        );
      },
    );
  }
}

class _ConfettiParticle {
  final double x;
  final double delay;
  final double speed;
  final double size;
  final Color color;
  final double wobble;
  final double wobbleSpeed;

  _ConfettiParticle({
    required this.x,
    required this.delay,
    required this.speed,
    required this.size,
    required this.color,
    required this.wobble,
    required this.wobbleSpeed,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;

  _ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final adjustedProgress = ((progress - p.delay) / (1 - p.delay)).clamp(
        0.0,
        1.0,
      );
      if (adjustedProgress <= 0) continue;

      final x =
          p.x * size.width +
          math.sin(adjustedProgress * p.wobbleSpeed * math.pi + p.wobble) * 40;
      final y = -20 + adjustedProgress * (size.height + 40) * p.speed;

      final opacity = adjustedProgress < 0.8
          ? 1.0
          : (1.0 - (adjustedProgress - 0.8) / 0.2);

      final paint = Paint()
        ..color = p.color.withOpacity(opacity.clamp(0.0, 1.0))
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(adjustedProgress * math.pi * 4 + p.wobble);

      // Draw small rectangles for confetti
      final rect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset.zero,
          width: p.size,
          height: p.size * 0.6,
        ),
        const Radius.circular(1),
      );
      canvas.drawRRect(rect, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
