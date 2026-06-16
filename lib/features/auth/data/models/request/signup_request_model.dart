class SignupRequestModel {
  SignupRequestModel({
    required this.email,
    required this.password,
    required this.name,
  });

  final String email;
  final String password;
  final String name;

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
  };
}
