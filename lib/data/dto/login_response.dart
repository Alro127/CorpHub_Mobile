class LoginResponse {
  final String id;
  final String fullName;
  final String role;
  final String token;
  final String email;

  LoginResponse({
    required this.id,
    required this.fullName,
    required this.role,
    required this.token,
    required this.email,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      role: json['role'] as String,
      token: json['token'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'role': role,
      'token': token,
      'email': email,
    };
  }
}
