import 'package:flutter/material.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.rubik.copyWith(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: foregroundColor,
          ),
        ),
      ),
    );
  }
}
