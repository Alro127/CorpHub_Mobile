class TicketRequest {
  final int? id;
  final String title;
  final String description;
  final String priority;
  final int categoryId;
  final int requesterId;
  final int? assignedToId;
  final int departmentId;

  TicketRequest({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.categoryId,
    required this.requesterId,
    this.assignedToId,
    required this.departmentId
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'categoryId': categoryId,
      'requesterId': requesterId,
      'assignedToId': assignedToId,
      'departmentId': departmentId
    };
  }
}
