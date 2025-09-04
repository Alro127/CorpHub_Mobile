class ProjectResponse {
  final String id;
  final String name;
  final String description;

  ProjectResponse({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return ProjectResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
