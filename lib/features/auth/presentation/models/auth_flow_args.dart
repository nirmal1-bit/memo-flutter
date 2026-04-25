class AuthFlowArgs {
  const AuthFlowArgs({
    this.email = '',
    this.resetToken = '',
    this.isResetPasswordFlow = false,
  });

  final String email;
  final String resetToken;
  final bool isResetPasswordFlow;
}
