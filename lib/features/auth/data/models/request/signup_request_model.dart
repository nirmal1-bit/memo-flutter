class SignupRequestModel {
  SignupRequestModel({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
  });

  final String email;
  final String password;
  final String name;
  final String role;

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    'role': 'normal',
  };
}
