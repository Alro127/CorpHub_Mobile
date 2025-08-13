class Ticket {
  String ticketId;
  String title;
  String status;
  String priority;
  String requester;
  String technician;
  String createdDate;
  String deadline;
  int attachments;

  Ticket({
    required this.ticketId,
    required this.title,
    required this.status,
    required this.priority,
    required this.requester,
    required this.technician,
    required this.createdDate,
    required this.deadline,
    required this.attachments,
  });
}
