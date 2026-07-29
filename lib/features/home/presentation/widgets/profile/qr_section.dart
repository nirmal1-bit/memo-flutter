import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/home/presentation/widgets/profile/section_card.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrSection extends StatelessWidget {
  const QrSection({super.key, required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'My QR Code',
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.brandBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: QrImageView(
            data: userId.toString(),
            version: QrVersions.auto,
            size: 160,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
