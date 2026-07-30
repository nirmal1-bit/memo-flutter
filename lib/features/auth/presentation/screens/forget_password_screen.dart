import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/auth/presentation/cubits/resend_token_cubit.dart';
import 'package:memo/features/auth/presentation/models/auth_flow_args.dart';
import 'package:memo/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:memo/features/common/form_widgets.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<ResendTokenCubit>())],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ResendTokenCubit, BaseApiState<String>>(
            listener: (context, state) {
              state.maybeWhen(
                success: (_) {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: 'Reset code sent to your email.',
                  );
                  context.push(
                    AppRoutes.verifyToken,
                    extra: AuthFlowArgs(
                      email: _emailController.text.trim(),
                      isResetPasswordFlow: true,
                    ),
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
        child: BlocBuilder<ResendTokenCubit, BaseApiState<String>>(
          builder: (context, state) {
            return ForgetPasswordView(
              formKey: _formKey,
              emailController: _emailController,
              isLoading: state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              ),
              onSendPressed: () {
                if (!(_formKey.currentState?.validate() ?? false)) {
                  return;
                }

                context.read<ResendTokenCubit>().requestToken(
                  _emailController.text.trim(),
                );
              },
              onBackPressed: () => context.pop(),
            );
          },
        ),
      ),
    );
  }
}

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.isLoading,
    required this.onSendPressed,
    required this.onBackPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final bool isLoading;
  final VoidCallback onSendPressed;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthShell(
        title: 'Reset password',
        subtitle:
            'Enter the email tied to your account and we will send a verification code.',
        showBackButton: true,
        onBack: onBackPressed,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputField(
                controller: emailController,
                label: 'Email',
                hint: 'you@example.com',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter your email'
                    : null,
              ),
              const SizedBox(height: 24),
              AuthPrimaryButton(
                label: 'Send reset code',
                isLoading: isLoading,
                onPressed: onSendPressed,
              ),
              const SizedBox(height: 14),
              AuthTextLink(label: 'Back to sign in', onPressed: onBackPressed),
              const SizedBox(height: 6),
              Text(
                'If you already have a code, you can continue from the verification screen.',
                textAlign: TextAlign.center,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 12,
                  color: AppColors.textCaption,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
