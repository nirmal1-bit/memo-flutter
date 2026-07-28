class AuthFlowArgs {
  const AuthFlowArgs({
    this.email = '',
    this.password = '',
    this.resetToken = '',
    this.isResetPasswordFlow = false,
  });

  final String email;
  final String password;
  final String resetToken;
  final bool isResetPasswordFlow;
}
