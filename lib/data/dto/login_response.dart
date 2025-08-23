class LoginResponse {
  final int id;
  final String fullName;
  final String role;
  final String token;
  final String status;

  LoginResponse({
    required this.id,
    required this.fullName,
    required this.role,
    required this.token,
    required this.status,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      role: json['role'] as String,
      token: json['token'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'role': role,
      'token': token,
      'status': status,
    };
  }
}
