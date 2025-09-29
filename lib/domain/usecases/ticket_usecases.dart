import 'package:ticket_helpdesk/data/dto/ticket_rejection_dto.dart';
import 'package:ticket_helpdesk/data/dto/ticket_request.dart';
import 'package:ticket_helpdesk/data/dto/ticket_response.dart';
import 'package:ticket_helpdesk/data/repositories/ticket_repository.dart';
import 'package:ticket_helpdesk/data/dto/ticket_category.dart';

class TicketUseCase {
  final TicketRepository repository;
  TicketUseCase(this.repository);

  Future<List<TicketResponse>> fetchTickets() async {
    final tickets = await repository.fetchTickets();
    return tickets;
  }

  Future<bool> saveTicket(TicketRequest ticket) {
    // validation / business rule đơn giản có thể đặt ở đây
    if (ticket.title.isEmpty) throw ArgumentError('title required');
    return repository.saveTicket(ticket);
  }

  Future<bool> deleteTicket(String id) => repository.deleteTicket(id);

  Future<List<TicketCategory>> fetchCategories() =>
      repository.fetchCategories();

  Future<bool> acceptTicket(String ticketId) {
    return repository.takeOver(ticketId);
  }

  Future<bool> rejectTicket(TicketRejectionDto ticketRejectionDto) {
    return repository.reject(ticketRejectionDto);
  }

  Future<bool> completeTicket(String ticketId) {
    return repository.complete(ticketId);
  }

  /*  Future<List<Ticket>> searchTickets(String q) => repository.searchTickets(q);*/
}
