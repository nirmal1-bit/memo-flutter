import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class TranscriptCard extends StatelessWidget {
  const TranscriptCard({super.key, required this.text, this.aiText = ''});

  final String text;
  final String aiText;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: text.isEmpty && aiText.isEmpty
          ? const SizedBox.shrink()
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 28),
              constraints: const BoxConstraints(maxHeight: 220),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.darkElevatedSurface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  width: 1,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (text.isNotEmpty)
                      _TranscriptLine(label: 'You', text: text),
                    if (text.isNotEmpty && aiText.isNotEmpty)
                      const SizedBox(height: 14),
                    if (aiText.isNotEmpty)
                      _TranscriptLine(label: 'Menmo AI', text: aiText),
                  ],
                ),
              ),
            ),
    );
  }
}

class _TranscriptLine extends StatelessWidget {
  const _TranscriptLine({required this.label, required this.text});

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 5, right: 10),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  height: 1.55,
                  color: AppColors.lightWhite,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
