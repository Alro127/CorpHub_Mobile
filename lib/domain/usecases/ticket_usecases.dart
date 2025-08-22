import 'package:ticket_helpdesk/data/repositories/ticket_repository.dart';
import 'package:ticket_helpdesk/domain/dto/ticket_request.dart';
import 'package:ticket_helpdesk/domain/dto/ticket_response.dart';
import 'package:ticket_helpdesk/domain/models/ticket_category.dart';


class TicketUseCase {
  final TicketRepository repository;
  TicketUseCase(this.repository);

  Future<List<TicketResponse>> fetchTickets() => repository.fetchTickets();

  Future<bool> saveTicket(TicketRequest ticket) {
    // validation / business rule đơn giản có thể đặt ở đây
    if (ticket.title.isEmpty) throw ArgumentError('title required');
    return repository.saveTicket(ticket);
  }


  Future<bool> deleteTicket(int id) => repository.deleteTicket(id);

  Future<List<TicketCategory>> fetchCategories() => repository.fetchCategories();

/*  Future<List<Ticket>> searchTickets(String q) => repository.searchTickets(q);*/
}
