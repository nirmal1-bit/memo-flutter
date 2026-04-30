import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/network/data/models/response/user_search_response.dart';
import 'package:memo/features/network/presentation/cubits/connection_action_cubit.dart';
import 'package:memo/features/network/presentation/cubits/search_users_cubit.dart';
import 'package:memo/features/network/presentation/widgets/avatar_badge.dart';
import 'package:memo/features/network/presentation/widgets/network_search_bar.dart';

class AddConnectionScreen extends StatefulWidget {
  const AddConnectionScreen({super.key});

  @override
  State<AddConnectionScreen> createState() => _AddConnectionScreenState();
}

class _AddConnectionScreenState extends State<AddConnectionScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SearchUsersCubit>()),
        BlocProvider(create: (_) => getIt<ConnectionActionCubit>()),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<ConnectionActionCubit, BaseApiState<String>>(
            listener: (context, state) {
              state.maybeWhen(
                success: (message) {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: message,
                  );
                },
                error: (message) {
                  AppUtils.showErrorSnackbar(
                    context: context,
                    message: message,
                  );
                },
                validationError: (validationError) {
                  AppUtils.showErrorSnackbar(
                    context: context,
                    message: validationError.message,
                  );
                },
                noInternet: () {
                  AppUtils.showErrorSnackbar(
                    context: context,
                    message: 'No internet connection',
                  );
                },
                orElse: () {},
              );
            },
            child: Scaffold(
              backgroundColor: AppColors.scaffoldBackground,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.scaffoldBackground,
                elevation: 0,
                foregroundColor: AppColors.softPrimary,
                title: Text(
                  'Add connection',
                  style: AppTextStyles.libre.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.softPrimary,
                  ),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _QrActionCard(onTap: () {}),
                      const SizedBox(height: 20),
                      Text(
                        'Search people',
                        style: AppTextStyles.libre.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.softPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      NetworkSearchBar(
                        controller: _searchController,
                        onSubmitted: (value) =>
                            context.read<SearchUsersCubit>().searchUsers(value),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => context
                              .read<SearchUsersCubit>()
                              .searchUsers(_searchController.text),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                          ),
                          icon: const Icon(Icons.search_rounded, size: 18),
                          label: Text(
                            'Search',
                            style: AppTextStyles.rubik.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<
                        SearchUsersCubit,
                        BaseApiState<List<UserSearchResponse>>
                      >(
                        builder: (context, state) {
                          return state.when(
                            initial: () => const _HintCard(
                              icon: Icons.person_search_outlined,
                              title: 'Search for new people',
                              message: 'Type a name or email and tap search.',
                            ),
                            loading: () => const _LoadingCard(),
                            success: (results) => results.isEmpty
                                ? const _HintCard(
                                    icon: Icons.search_off_rounded,
                                    title: 'No users found',
                                    message:
                                        'Try a different name, email, or username.',
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Results',
                                        style: AppTextStyles.libre.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.softPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      ...results.map(
                                        (result) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 12,
                                          ),
                                          child: _SearchResultCard(
                                            result: result,
                                            onSendRequest: () => context
                                                .read<ConnectionActionCubit>()
                                                .sendConnectionRequest(
                                                  result.user.id,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            error: (message) => _HintCard(
                              icon: Icons.error_outline_rounded,
                              title: 'Search failed',
                              message: message,
                            ),
                            noInternet: () => const _HintCard(
                              icon: Icons.wifi_off_rounded,
                              title: 'No internet connection',
                              message: 'Check your connection and try again.',
                            ),
                            validationError: (validationError) => _HintCard(
                              icon: Icons.warning_amber_rounded,
                              title: validationError.message,
                              message: validationError.errors.isNotEmpty
                                  ? validationError.errors.values.first
                                        .toString()
                                  : '',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _QrActionCard extends StatelessWidget {
  const _QrActionCard({required this.onTap});

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

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({required this.result, required this.onSendRequest});

  final UserSearchResponse result;
  final VoidCallback onSendRequest;

  @override
  Widget build(BuildContext context) {
    final user = result.user;
    final profile = result.profile;

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            AvatarBadge(
              profileLink: profile?.avatarUrl ?? '',
              label: _initials(user.name),
              size: 54,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.softBlack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 12.5,
                      color: AppColors.ironGrey,
                    ),
                  ),
                  if ((profile?.headline ?? '').isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      profile!.headline,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 12.5,
                        color: AppColors.softTextGrey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: onSendRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                'Request',
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HintCard extends StatelessWidget {
  const _HintCard({
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.softBlack,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  message,
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 12.5,
                    color: AppColors.softTextGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2.4),
          ),
          const SizedBox(width: 12),
          Text(
            'Searching people...',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13,
              color: AppColors.softTextGrey,
            ),
          ),
        ],
      ),
    );
  }
}

String _initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty) return 'N';
  final first = parts.first.isNotEmpty ? parts.first[0] : 'N';
  final second = parts.length > 1 && parts[1].isNotEmpty ? parts[1][0] : '';
  return (first + second).toUpperCase();
}
