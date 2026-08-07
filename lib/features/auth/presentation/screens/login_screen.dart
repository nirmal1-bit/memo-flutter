import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/services/fcm_service.dart';
import 'package:memo/core/session/session_service.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/auth/data/models/request/login_request_model.dart';
import 'package:memo/features/auth/data/models/response/authentication_token.dart';
import 'package:memo/features/auth/presentation/cubits/login_cubit.dart';
import 'package:memo/features/auth/presentation/cubits/face_verified_cubit.dart';
import 'package:memo/features/auth/presentation/models/auth_flow_args.dart';
import 'package:memo/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:memo/features/common/form_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LoginCubit>()),
        //TODO: fix this
        BlocProvider(create: (_) => getIt<FaceVerifiedCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<FaceVerifiedCubit, BaseApiState<bool>>(
            listener: (context, state) {
              state.maybeWhen(
                success: (faceVerified) {
                  final request = LoginRequestModel(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                  if (faceVerified) {
                    context.push(
                      AppRoutes.loginFaceVerification,
                      extra: AuthFlowArgs(
                        email: request.email,
                        password: request.password,
                      ),
                    );
                  } else {
                    context.read<LoginCubit>().login(request);
                  }
                },
                error: (message) => AppUtils.showErrorSnackbar(
                  context: context,
                  message: message,
                ),
                validationError: (error) => AppUtils.showErrorSnackbar(
                  context: context,
                  message: error.message,
                ),
                noInternet: () => AppUtils.showErrorSnackbar(
                  context: context,
                  message: 'No internet connection',
                ),
                orElse: () {},
              );
            },
          ),
          BlocListener<LoginCubit, BaseApiState<AuthenticationToken>>(
            listener: (context, state) async {
              state.maybeWhen(
                success: (data) async {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: 'Signed in successfully',
                  );
                  getIt<FCMService>().init();
                  await SessionService().saveToken(data.token);
                  if (!context.mounted) {
                    return;
                  }
                  context.go(AppRoutes.main);
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
        child: BlocBuilder<LoginCubit, BaseApiState<AuthenticationToken>>(
          builder: (context, state) {
            return LoginView(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
              obscurePassword: _obscurePassword,
              isLoading:
                  state.maybeWhen(loading: () => true, orElse: () => false) ||
                  context.watch<FaceVerifiedCubit>().state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  ),
              onTogglePassword: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              onLoginPressed: () {
                if (!(_formKey.currentState?.validate() ?? false)) {
                  return;
                }

                context.read<FaceVerifiedCubit>().check(
                  LoginRequestModel(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  ),
                );
              },
              onForgotPasswordPressed: () =>
                  context.push(AppRoutes.forgetPassword),
              onCreateAccountPressed: () => context.push(AppRoutes.signUp),
            );
          },
        ),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onLoginPressed,
    required this.onForgotPasswordPressed,
    required this.onCreateAccountPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onCreateAccountPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AuthShell(
        title: 'Welcome back',
        subtitle:
            'Sign in to continue your Menmo flow and pick up where you left off.',
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
              const SizedBox(height: 16),
              InputField(
                controller: passwordController,
                label: 'Password',
                hint: '••••••••',
                icon: Icons.lock_outline_rounded,
                obscureText: obscurePassword,
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter your password'
                    : null,
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
              const SizedBox(height: 8),
              AuthTextLink(
                label: 'Forgot password?',
                alignment: Alignment.centerRight,
                onPressed: onForgotPasswordPressed,
              ),
              const SizedBox(height: 6),
              AuthPrimaryButton(
                label: 'Sign in',
                isLoading: isLoading,
                onPressed: onLoginPressed,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.dividerColor.withOpacity(0.65),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      'new here?',
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textCaption,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.dividerColor.withOpacity(0.65),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              AuthTextLink(
                label: 'Create an account',
                onPressed: onCreateAccountPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
