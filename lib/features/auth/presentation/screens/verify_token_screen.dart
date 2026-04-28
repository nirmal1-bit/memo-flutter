import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/auth/presentation/cubits/resend_token_cubit.dart';
import 'package:memo/features/auth/presentation/cubits/verify_token_cubit.dart';
import 'package:memo/features/auth/presentation/models/auth_flow_args.dart';
import 'package:memo/features/auth/presentation/widgets/auth_widgets.dart';

class VerifyTokenScreen extends StatefulWidget {
  const VerifyTokenScreen({super.key, this.arguments});

  final AuthFlowArgs? arguments;

  @override
  State<VerifyTokenScreen> createState() => _VerifyTokenScreenState();
}

class _VerifyTokenScreenState extends State<VerifyTokenScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tokenController = TextEditingController();

  AuthFlowArgs get _arguments => widget.arguments ?? const AuthFlowArgs();

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<VerifyTokenCubit>()),
        BlocProvider(create: (_) => getIt<ResendTokenCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<VerifyTokenCubit, BaseApiState<String>>(
            listener: (context, state) {
              state.maybeWhen(
                success: (_) {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: _arguments.isResetPasswordFlow
                        ? 'Email verified. Create a new password.'
                        : 'Email verified successfully.',
                  );

                  if (_arguments.isResetPasswordFlow) {
                    context.push(
                      AppRoutes.newPassword,
                      extra: AuthFlowArgs(
                        email: _arguments.email,
                        resetToken: _tokenController.text.trim(),
                        isResetPasswordFlow: true,
                      ),
                    );
                    return;
                  }
                  context.go(AppRoutes.login);
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
          ),
          BlocListener<ResendTokenCubit, BaseApiState<String>>(
            listener: (context, state) {
              state.maybeWhen(
                success: (_) {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: _arguments.isResetPasswordFlow
                        ? 'Reset code sent again.'
                        : 'Verification code sent again.',
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
          ),
        ],
        child: BlocBuilder<VerifyTokenCubit, BaseApiState<String>>(
          builder: (context, verifyState) {
            return BlocBuilder<ResendTokenCubit, BaseApiState<String>>(
              builder: (context, resendState) {
                return VerifyTokenView(
                  formKey: _formKey,
                  tokenController: _tokenController,
                  email: _arguments.email,
                  isResetPasswordFlow: _arguments.isResetPasswordFlow,
                  isLoading: verifyState.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  ),
                  isResending: resendState.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  ),
                  onVerifyPressed: () {
                    if (!(_formKey.currentState?.validate() ?? false)) {
                      return;
                    }

                    final token = _tokenController.text.trim();
                    if (_arguments.isResetPasswordFlow) {
                      context
                          .read<VerifyTokenCubit>()
                          .verifyTokenForgetPassword(token);
                      return;
                    }

                    context.read<VerifyTokenCubit>().verifyToken(token);
                  },
                  onResendPressed: () {
                    final email = _arguments.email.trim();
                    if (email.isEmpty) {
                      AppUtils.showErrorSnackbar(
                        context: context,
                        message: 'Email is required to resend the code.',
                      );
                      return;
                    }

                    if (_arguments.isResetPasswordFlow) {
                      context.read<ResendTokenCubit>().requestToken(email);
                      return;
                    }

                    context.read<ResendTokenCubit>().resendToken(email);
                  },
                  onBackPressed: () => context.pop(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class VerifyTokenView extends StatelessWidget {
  const VerifyTokenView({
    super.key,
    required this.formKey,
    required this.tokenController,
    required this.email,
    required this.isResetPasswordFlow,
    required this.isLoading,
    required this.isResending,
    required this.onVerifyPressed,
    required this.onResendPressed,
    required this.onBackPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController tokenController;
  final String email;
  final bool isResetPasswordFlow;
  final bool isLoading;
  final bool isResending;
  final VoidCallback onVerifyPressed;
  final VoidCallback onResendPressed;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    final String subtitle = isResetPasswordFlow
        ? 'Enter the verification code sent to $email so we can let you create a new password.'
        : 'Enter the verification code sent to $email to activate your account.';

    return Scaffold(
      body: AuthShell(
        title: 'Verify code',
        subtitle: subtitle,
        showBackButton: true,
        onBack: onBackPressed,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: tokenController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 6,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 20,
                  letterSpacing: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.softPrimary,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '000000',
                  hintStyle: AppTextStyles.rubik.copyWith(
                    fontSize: 18,
                    color: AppColors.softPrimary.withOpacity(0.35),
                    letterSpacing: 8,
                  ),
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppColors.dividerColor.withOpacity(0.7),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppColors.dividerColor.withOpacity(0.7),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.4,
                    ),
                  ),
                ),
                validator: (value) => value == null || value.trim().length < 4
                    ? 'Enter the code'
                    : null,
              ),
              const SizedBox(height: 22),
              AuthPrimaryButton(
                label: 'Verify code',
                isLoading: isLoading,
                onPressed: onVerifyPressed,
              ),
              const SizedBox(height: 14),
              AuthPrimaryButton(
                label: isResending ? 'Sending...' : 'Resend code',
                isLoading: isResending,
                onPressed: onResendPressed,
              ),
              const SizedBox(height: 14),
              AuthTextLink(label: 'Back', onPressed: onBackPressed),
            ],
          ),
        ),
      ),
    );
  }
}
