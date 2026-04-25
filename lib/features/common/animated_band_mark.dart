// ── BrandMark ─────────────────────────────────────────────────────────────────
// Animated logo for InkList — "digitize your handwritten life"
// Uses: flutter_animate (pub.dev/packages/flutter_animate)
//
// Animations:
//  1. Icon container — elastic scale + fade pop-in with slight rotation
//  2. Ink-drop dot   — elastic scale pop, delayed after icon
//  3. "Ink" text     — fade + slide from left
//  4. "List" text    — fade + slide from left, staggered after "Ink"
//  5. Idle shimmer   — ShaderMask sweep that loops every 3 s
//
// Usage:
//   const BrandMark()               // animated (default)
//   const BrandMark(animate: false) // static — skips entry, no shimmer
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ── Replace with your real AppColors / AppTextStyles ─────────────────────────
class _C {
  static const Color primaryDark = Color(0xFF1A1A2E);
  static const Color accent = Color(0xFF4F46E5); // indigo
  static const Color accentLight = Color(0xFF818CF8); // soft indigo
  static const Color white = Colors.white;
}
// ─────────────────────────────────────────────────────────────────────────────

class AnimatedBandMark extends StatelessWidget {
  const AnimatedBandMark({super.key, this.animate = true});

  final bool animate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_buildIcon(), const SizedBox(width: 10), _buildWordmark()],
    );
  }

  // ── Icon tile ───────────────────────────────────────────────────────────────
  Widget _buildIcon() {
    final icon = Stack(
      clipBehavior: Clip.none,
      children: [
        // Rounded tile with gradient
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF5B52F0), Color(0xFF312E81)],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4F46E5).withOpacity(0.45),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Notebook ruled-line texture
              ..._ruledLines(),
              // Pen icon
              const Icon(Icons.edit_rounded, color: _C.white, size: 20),
            ],
          ),
        ),

        // Ink-drop dot — gets its own animation
        Positioned(right: -3, bottom: -3, child: _buildDot()),
      ],
    );

    if (!animate) return icon;

    // Entry: scale from 0.3 + fade in + slight rotate — elastic bounce
    return icon
        .animate()
        .fadeIn(duration: 250.ms, curve: Curves.easeOut)
        .scale(
          begin: const Offset(0.3, 0.3),
          end: const Offset(1.0, 1.0),
          duration: 550.ms,
          curve: Curves.elasticOut,
        )
        .rotate(
          begin: -0.08,
          end: 0,
          duration: 420.ms,
          curve: Curves.easeOutCubic,
        );
  }

  // ── Ink-drop dot ────────────────────────────────────────────────────────────
  Widget _buildDot() {
    final dot = Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: _C.accentLight,
        shape: BoxShape.circle,
        border: Border.all(color: _C.white, width: 1.8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.55),
            blurRadius: 5,
          ),
        ],
      ),
    );

    if (!animate) return dot;

    // Pops in after the icon settles, with elastic overshoot
    return dot
        .animate(delay: 380.ms)
        .scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          duration: 420.ms,
          curve: Curves.elasticOut,
        );
  }

  // ── Wordmark: "Ink" + "List" ─────────────────────────────────────────────────
  Widget _buildWordmark() {
    const baseStyle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w900,
      letterSpacing: -1.0,
      height: 1.0,
    );

    Widget inkText = Text('Ink', style: baseStyle.copyWith(color: _C.accent));

    Widget listText = Text(
      'List',
      style: baseStyle.copyWith(color: _C.primaryDark),
    );

    if (animate) {
      // "Ink" — slides in from left, starts after icon appears
      inkText = inkText
          .animate(delay: 260.ms)
          .fadeIn(duration: 280.ms, curve: Curves.easeOut)
          .slideX(
            begin: -0.35,
            end: 0,
            duration: 320.ms,
            curve: Curves.easeOutCubic,
          );

      // "List" — slightly later, like a typewriter stagger
      listText = listText
          .animate(delay: 360.ms)
          .fadeIn(duration: 280.ms, curve: Curves.easeOut)
          .slideX(
            begin: -0.25,
            end: 0,
            duration: 300.ms,
            curve: Curves.easeOutCubic,
          );
    }

    // Both words wrapped in a shimmer that loops after entry settles
    return _LoopingShimmer(
      enabled: animate,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [inkText, listText],
      ),
    );
  }

  // ── Ruled-line texture ───────────────────────────────────────────────────────
  List<Widget> _ruledLines() {
    const color = Color(0x1FFFFFFF);
    return [
      for (final dy in [-7.0, -2.0, 3.0, 8.0])
        Positioned(
          top: 22 + dy,
          left: 8,
          right: 8,
          child: Container(height: 0.75, color: color),
        ),
    ];
  }
}

// ── Looping shimmer sweep ─────────────────────────────────────────────────────
// Waits for the entry animation to finish, then repeats a shimmer every 3 s.
class _LoopingShimmer extends StatelessWidget {
  const _LoopingShimmer({required this.child, required this.enabled});

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return child
        .animate(
          delay: 1400.ms, // let the entry finish first
          onPlay: (controller) => controller.repeat(period: 3000.ms),
        )
        .shimmer(
          duration: 900.ms,
          color: _C.white.withOpacity(0.35),
          angle: 0, // horizontal left-to-right sweep
          size: 0.4, // width of the shimmer band (0–1)
        );
  }
}
