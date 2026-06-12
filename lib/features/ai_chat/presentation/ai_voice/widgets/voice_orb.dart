import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

import 'dashed_ring_painter.dart';
import 'orb_icon.dart';

class VoiceOrb extends StatelessWidget {
  const VoiceOrb({
    super.key,
    required this.isListening,
    required this.isProcessing,
    required this.pulseAnim,
    required this.rotationController,
    required this.onTap,
  });

  final bool isListening;
  final bool isProcessing;
  final Animation<double> pulseAnim;
  final AnimationController rotationController;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 220,
        height: 220,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Rotating dashed ring — only while listening
            if (isListening)
              AnimatedBuilder(
                animation: rotationController,
                builder: (_, _) => Transform.rotate(
                  angle: rotationController.value * 2 * math.pi,
                  child: CustomPaint(
                    size: const Size(210, 210),
                    painter: DashedRingPainter(
                      color: AppColors.primary.withOpacity(0.6),
                    ),
                  ),
                ),
              ),

            // Pulsing glow ring
            AnimatedBuilder(
              animation: pulseAnim,
              builder: (_, child) => Transform.scale(
                scale: isListening ? pulseAnim.value : 1.0,
                child: child,
              ),
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: isProcessing
                        ? [
                            AppColors.secondary.withOpacity(0.3),
                            AppColors.secondary2.withOpacity(0.1),
                            Colors.transparent,
                          ]
                        : isListening
                        ? [
                            AppColors.primary.withOpacity(0.35),
                            AppColors.primary.withOpacity(0.08),
                            Colors.transparent,
                          ]
                        : [
                            AppColors.darkElevatedSurface.withOpacity(0.6),
                            Colors.transparent,
                          ],
                  ),
                ),
              ),
            ),

            // Core orb button
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              width: isListening ? 130 : 120,
              height: isListening ? 130 : 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isProcessing
                      ? [AppColors.secondary, AppColors.secondary2]
                      : isListening
                      ? [AppColors.primary, AppColors.softPrimary]
                      : [AppColors.darkElevatedSurface, AppColors.darkSurface],
                ),
                boxShadow: [
                  BoxShadow(
                    color: isProcessing
                        ? AppColors.secondary.withOpacity(0.5)
                        : isListening
                        ? AppColors.primary.withOpacity(0.55)
                        : Colors.black38,
                    blurRadius: isListening ? 36 : 16,
                    spreadRadius: isListening ? 4 : 0,
                  ),
                ],
              ),
              child: OrbIcon(
                isListening: isListening,
                isProcessing: isProcessing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
