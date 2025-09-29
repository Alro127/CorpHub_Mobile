class TicketRejectionDto {
  final String ticketId;
  final String reason;

  TicketRejectionDto({required this.ticketId, required this.reason});

  Map<String, dynamic> toJson() {
    return {'ticketId': ticketId, 'reason': reason};
  }
}
