import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class PulsingDotIndicator extends StatefulWidget {
  const PulsingDotIndicator({
    super.key,
    this.color,
    this.size = 10,
    this.dotCount = 3,
  });

  final Color? color;
  final double size;
  final int dotCount;

  @override
  State<PulsingDotIndicator> createState() => _PulsingDotIndicatorState();
}

class _PulsingDotIndicatorState extends State<PulsingDotIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.dotCount, (i) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      );
    });
    _animations = _controllers.map((c) {
      return Tween<double>(
        begin: 0,
        end: -12,
      ).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut));
    }).toList();

    for (int i = 0; i < widget.dotCount; i++) {
      Future.delayed(Duration(milliseconds: i * 180), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.primary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.dotCount, (i) {
        return AnimatedBuilder(
          animation: _animations[i],
          builder: (_, __) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              child: Transform.translate(
                offset: Offset(0, _animations[i].value),
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
