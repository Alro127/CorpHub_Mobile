class Ticket {
  final int ticketId;
  final String title;
  final String description;
  final String priority;
  final String status;
  final int categoryId;
  final int requesterId;
  final int? assignedTo;
  final String? resolvedAt;
  final String createdAt;
  final String updatedAt;

  Ticket({
    required this.ticketId,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.categoryId,
    required this.requesterId,
    this.assignedTo,
    this.resolvedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      ticketId: json['ticket_id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      status: json['status'],
      categoryId: json['category_id'],
      requesterId: json['requester_id'],
      assignedTo: json['assigned_to'],
      resolvedAt: json['resolved_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
