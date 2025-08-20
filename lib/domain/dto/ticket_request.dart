class TicketRequest {
  final int? id;
  final String title;
  final String description;
  final String priority;
  final String status;
  final int categoryId;
  final int requesterId;
  final int? assignedToId;

  TicketRequest({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.categoryId,
    required this.requesterId,
    this.assignedToId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'categoryId': categoryId,
      'requesterId': requesterId,
      'assignedToId': assignedToId,
    };
  }
}
