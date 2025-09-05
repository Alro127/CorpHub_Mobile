class TicketRequest {
  final String? id;
  final String title;
  final String description;
  final String priority;
  final String categoryId;
  final String? assigneeId;
  final String departmentId;

  TicketRequest({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.categoryId,
    this.assigneeId,
    required this.departmentId,
  });

  Map<String, dynamic> toJson() {
    final data = {
      'title': title,
      'description': description,
      'priority': priority,
      'categoryId': categoryId,
      'assigneeId': assigneeId,
      'departmentId': departmentId,
    };

    if (id != null) {
      data['id'] = id;
    }

    return data;
  }
}
