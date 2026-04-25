class NewPasswordRequest {
  NewPasswordRequest({
    required this.conform,
    required this.password,
    required this.resetToken,
  });

  final String conform;
  final String password;
  final String resetToken;

  Map<String, dynamic> toJson() => {
    'conform': conform,
    'password': password,
    'reset_token': resetToken,
  };
}
