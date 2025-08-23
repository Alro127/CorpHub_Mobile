class DepartmentBasicInfoDto {
  final int id;
  final String departmentName;

  DepartmentBasicInfoDto({required this.id, required this.departmentName});

  factory DepartmentBasicInfoDto.fromJson(Map<String, dynamic> json) {
    return DepartmentBasicInfoDto(id: json['id'], departmentName: json['departmentName']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'departmentName': departmentName};
  }
}