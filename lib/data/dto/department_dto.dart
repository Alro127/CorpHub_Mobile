class DepartmentDto {
  final String id;
  final String name;
  final String description;

  DepartmentDto({
    required this.id,
    required this.name,
    required this.description,
  });

  factory DepartmentDto.fromJson(Map<String, dynamic> json) {
    return DepartmentDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
