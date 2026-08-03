import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/auth/data/models/request/new_password_request.dart';
import 'package:memo/features/auth/presentation/cubits/new_password_cubit.dart';
import 'package:memo/features/auth/presentation/models/auth_flow_args.dart';
import 'package:memo/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:memo/features/common/form_widgets.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, this.arguments});

  final AuthFlowArgs? arguments;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tokenController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;

  AuthFlowArgs get _arguments => widget.arguments ?? const AuthFlowArgs();

  @override
  void initState() {
    super.initState();
    _tokenController.text = _arguments.resetToken;
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<NewPasswordCubit>())],
      child: MultiBlocListener(
        listeners: [
          BlocListener<NewPasswordCubit, BaseApiState<String>>(
            listener: (context, state) {
              state.maybeWhen(
                success: (_) {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: 'Password updated successfully.',
                  );
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
        ],
        child: BlocBuilder<NewPasswordCubit, BaseApiState<String>>(
          builder: (context, state) {
            return NewPasswordView(
              formKey: _formKey,
              email: _arguments.email,
              tokenController: _tokenController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
              obscurePassword: _obscurePassword,
              isLoading: state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              ),
              onTogglePassword: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              onSubmitPressed: () {
                if (!(_formKey.currentState?.validate() ?? false)) {
                  return;
                }

                context.read<NewPasswordCubit>().makeNewPassword(
                  NewPasswordRequest(
                    conform: _confirmPasswordController.text.trim(),
                    password: _passwordController.text.trim(),
                    resetToken: _tokenController.text.trim(),
                  ),
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

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({
    super.key,
    required this.formKey,
    required this.email,
    required this.tokenController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onSubmitPressed,
    required this.onBackPressed,
  });

  final GlobalKey<FormState> formKey;
  final String email;
  final TextEditingController tokenController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmitPressed;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    final subtitle = email.isEmpty
        ? 'Create a new password for your account.'
        : 'Create a new password for $email.';

    return Scaffold(
      body: AuthShell(
        title: 'New password',
        subtitle: subtitle,
        showBackButton: true,
        onBack: onBackPressed,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputField(
                controller: tokenController,
                label: 'Reset token',
                hint: 'Token from your email',
                icon: Icons.confirmation_num_outlined,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter the token'
                    : null,
              ),
              const SizedBox(height: 16),
              InputField(
                controller: passwordController,
                label: 'New password',
                hint: 'Enter a new password',
                icon: Icons.lock_outline_rounded,
                obscureText: obscurePassword,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a password' : null,
                suffix: GestureDetector(
                  onTap: onTogglePassword,
                  child: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: AppColors.textBody,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InputField(
                controller: confirmPasswordController,
                label: 'Confirm password',
                hint: 'Repeat the password',
                icon: Icons.verified_user_outlined,
                obscureText: obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              AuthPrimaryButton(
                label: 'Update password',
                isLoading: isLoading,
                onPressed: onSubmitPressed,
              ),
              const SizedBox(height: 14),
              AuthTextLink(label: 'Back to sign in', onPressed: onBackPressed),
              const SizedBox(height: 6),
              Text(
                'If the token has expired, request a new one from the reset screen.',
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
