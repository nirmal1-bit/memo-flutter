import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class OrbIcon extends StatelessWidget {
  const OrbIcon({
    super.key,
    required this.isListening,
    required this.isProcessing,
  });

  final bool isListening;
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    if (isProcessing) {
      return const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(
            color: AppColors.white,
            strokeWidth: 2.5,
          ),
        ),
      );
    }

    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          isListening ? Icons.stop_rounded : Icons.mic_rounded,
          key: ValueKey(isListening),
          color: AppColors.white,
          size: 44,
        ),
      ),
    );
  }
}
