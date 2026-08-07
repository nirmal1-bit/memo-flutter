import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class StatusLabel extends StatelessWidget {
  const StatusLabel({
    super.key,
    required this.message,
    required this.isListening,
    required this.isProcessing,
  });

  final String message;
  final bool isListening;
  final bool isProcessing;

  Color get _color {
    if (isProcessing) return AppColors.white;
    if (isListening) return AppColors.white;
    return AppColors.textGrey;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: _color,
        letterSpacing: 0.5,
      ),
      child: Text(message),
    );
  }
}
