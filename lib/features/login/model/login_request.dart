class LoginRequestModel {
  final String UserName;
  final String password;
  final String? email;

  LoginRequestModel({
    required this.UserName,
    required this.password,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {'userName': UserName.trim(), 'password': password, 'email': ''};
  }
}
