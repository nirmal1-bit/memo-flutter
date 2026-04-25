import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/auth/data/models/request/signup_request_model.dart';
import 'package:memo/features/auth/presentation/cubits/signup_cubit.dart';
import 'package:memo/features/auth/presentation/models/auth_flow_args.dart';
import 'package:memo/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:memo/features/common/form_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<SignupCubit>())],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SignupCubit, BaseApiState<String>>(
            listener: (context, state) {
              state.maybeWhen(
                success: (_) {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: 'Account created. Verify your email.',
                  );
                  context.push(
                    AppRoutes.verifyToken,
                    extra: AuthFlowArgs(email: _emailController.text.trim()),
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
        child: BlocBuilder<SignupCubit, BaseApiState<String>>(
          builder: (context, state) {
            return SignupView(
              formKey: _formKey,
              nameController: _nameController,
              emailController: _emailController,
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
              onSignUpPressed: () {
                if (!(_formKey.currentState?.validate() ?? false)) {
                  return;
                }

                context.read<SignupCubit>().signup(
                  SignupRequestModel(
                    name: _nameController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                    role: 'user',
                  ),
                );
              },
              onLoginPressed: () => context.pop(),
            );
          },
        ),
      ),
    );
  }
}

class SignupView extends StatelessWidget {
  const SignupView({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onSignUpPressed,
    required this.onLoginPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final VoidCallback onSignUpPressed;
  final VoidCallback onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthShell(
        title: 'Create account',
        subtitle: 'Set up your profile and start using Memo in a few steps.',
        showBackButton: true,
        onBack: onLoginPressed,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputField(
                controller: nameController,
                label: 'Name',
                hint: 'Your name',
                icon: Icons.person_outline_rounded,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter your name'
                    : null,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              InputField(
                controller: passwordController,
                label: 'Password',
                hint: 'Create a password',
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
                    color: AppColors.softPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InputField(
                controller: confirmPasswordController,
                label: 'Confirm password',
                hint: 'Repeat your password',
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
                label: 'Create account',
                isLoading: isLoading,
                onPressed: onSignUpPressed,
              ),
              const SizedBox(height: 14),
              AuthTextLink(
                label: 'Already have an account? Sign in',
                onPressed: onLoginPressed,
              ),
              const SizedBox(height: 6),
              Text(
                'Your account is created with the default user role.',
                textAlign: TextAlign.center,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 12,
                  color: AppColors.softPrimary.withOpacity(0.68),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
