import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:memo/features/network/presentation/widgets/network_connection_card.dart';

class NetworkStateView extends StatelessWidget {
  const NetworkStateView({
    super.key,
    required this.state,
    required this.emptyMessage,
  });

  final BaseApiState<List<ConnectionResponse>> state;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return state.when(
      initial: () => const _LoadingBox(),
      loading: () => const _LoadingBox(),
      success: (data) => data.isEmpty
          ? _EmptyState(message: emptyMessage)
          : Column(
              children: data
                  .map(
                    (connection) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: NetworkConnectionCard(connection: connection),
                    ),
                  )
                  .toList(),
            ),
      error: (message) => _MessageState(
        icon: Icons.error_outline_rounded,
        title: 'Something went wrong',
        message: message,
      ),
      noInternet: () => const _MessageState(
        icon: Icons.wifi_off_rounded,
        title: 'No internet connection',
        message: 'Check your connection and try again.',
      ),
      validationError: (validationError) => _MessageState(
        icon: Icons.warning_amber_rounded,
        title: validationError.message,
        message: validationError.errors.isNotEmpty
            ? validationError.errors.values.first.toString()
            : '',
      ),
    );
  }
}

class _LoadingBox extends StatelessWidget {
  const _LoadingBox();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 36),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.people_outline_rounded,
            color: AppColors.primary,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13.5,
              color: AppColors.softTextGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 40),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.libre.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.softPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13.5,
              color: AppColors.softTextGrey,
            ),
          ),
        ],
      ),
    );
  }
}
