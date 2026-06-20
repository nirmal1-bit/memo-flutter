import 'package:flutter/material.dart';

class SimilarityBadge extends StatelessWidget {
  const SimilarityBadge({super.key, required this.score});
  final double score;

  Color get _color {
    if (score >= 0.8) return const Color(0xFF22C55E); // green
    if (score >= 0.6) return const Color(0xFFF59E0B); // amber
    return const Color(0xFFEF4444); // red
  }

  @override
  Widget build(BuildContext context) {
    final pct = (score * 100).round();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.favorite, size: 11, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            '$pct% match',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
