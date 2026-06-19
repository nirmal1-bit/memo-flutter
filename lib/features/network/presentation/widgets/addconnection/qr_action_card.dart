import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class QrActionCard extends StatelessWidget {
  const QrActionCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(28),
      elevation: 6,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.brandBackground, AppColors.white],
            ),
          ),
          child: GestureDetector(
            onTap: () {
              context.push(AppRoutes.qrScanner);
            },
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.qr_code_2_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Scan QR code',
                        style: AppTextStyles.libre.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.softPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Scan QR and send instant connection requests.',
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 12.5,
                          color: AppColors.softTextGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.ironGrey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
