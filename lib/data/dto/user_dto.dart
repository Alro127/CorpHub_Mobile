import 'package:ticket_helpdesk/data/dto/department_dto.dart';

class UserDto {
  final String id;
  final DepartmentDto department;
  final String fullName;
  final String role;
  final String email;
  final String? phone;
  final DateTime dob;

  UserDto({
    required this.id,
    required this.department,
    required this.fullName,
    required this.role,
    required this.email,
    this.phone,
    required this.dob,
  });

  // fromJson: parse JSON thành object
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      department: DepartmentDto.fromJson(json['department']),
      fullName: json['fullName'],
      role: json['role'],
      email: json['email'],
      phone: json['phone'],
      dob: json['dob'],
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
      'dob': dob,
    };
  }
}
