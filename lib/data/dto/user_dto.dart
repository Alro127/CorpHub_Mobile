import 'package:ticket_helpdesk/domain/models/department_basic_info.dart';

class UserDto {
  final int id;
  final DepartmentBasicInfoDto department;
  final String fullName;
  final String role;
  final String email;
  final String? phone;
  final String status;

  UserDto({
    required this.id,
    required this.department,
    required this.fullName,
    required this.role,
    required this.email,
    this.phone,
    required this.status,
  });

  // fromJson: parse JSON thành object
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      department: DepartmentBasicInfoDto.fromJson(json['department']),
      fullName: json['fullName'],
      role: json['role'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
    );
  }

  // toJson: chuyển object thành JSON (nếu cần gửi ngược lên API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'department': department.toJson(),
      'fullName': fullName,
      'role': role,
      'email': email,
      'phone': phone,
      'status': status,
    };
  }
}
