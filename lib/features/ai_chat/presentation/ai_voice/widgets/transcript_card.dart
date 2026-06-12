import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class TranscriptCard extends StatelessWidget {
  const TranscriptCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: text.isEmpty
          ? const SizedBox.shrink()
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 28),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.darkElevatedSurface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.35),
                  width: 1,
                ),
              ),
              child: Row(
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
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        height: 1.55,
                        color: AppColors.lightWhite,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
