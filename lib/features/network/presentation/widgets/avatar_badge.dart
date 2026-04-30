import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class AvatarBadge extends StatelessWidget {
  const AvatarBadge({
    super.key,
    required this.profileLink,
    required this.label,
    this.size = 48,
  });

  final String profileLink;
  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    final hasProfileLink = profileLink.isNotEmpty;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasProfileLink
          ? Image.network(
              profileLink,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _FallbackLabel(label: label),
            )
          : _FallbackLabel(label: label),
    );
  }
}

class _FallbackLabel extends StatelessWidget {
  const _FallbackLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
