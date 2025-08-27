// lib/data/repositories/ticket_repository.dart

import 'package:ticket_helpdesk/data/api_service.dart';
import 'package:ticket_helpdesk/data/dto/ticket_request.dart';
import 'package:ticket_helpdesk/data/dto/ticket_response.dart';
import 'package:ticket_helpdesk/domain/models/ticket_category.dart';

class TicketRepository {
  final ApiService api;

  TicketRepository(this.api);

  Future<List<TicketResponse>> fetchTickets() async {
    try {
      final jsonResponse = await api.get('/api/tickets/get-all');
      final List<dynamic> data = (jsonResponse?['data'] ?? []) as List<dynamic>;
      final tickets = data.map((json) {
        try {
          final ticket = TicketResponse.fromJson(json);
          print("Parsed ticket: $ticket");
          return ticket;
        } catch (e, s) {
          print("Error parsing ticket: $e");
          print("JSON caused error: $json");
          print(s);
          rethrow;
        }
      }).toList();
      return tickets;
    } catch (e) {
      // Log hoặc throw tiếp nếu muốn ViewModel xử lý
      rethrow;
    }
  }

  Future<bool> saveTicket(TicketRequest ticket) async {
    try {
      await api.post('/api/tickets/save', ticket.toJson(), false);
      return true;
    } catch (e) {
      // Log hoặc xử lý lỗi
      return false;
    }
  }

  Future<bool> deleteTicket(int id) async {
    try {
      await api.delete('/api/tickets/delete/$id');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<TicketCategory>> fetchCategories() async {
    try {
      final response = await api.get('/api/tickets/categories');
      final List<dynamic> data = response?['data'] ?? [];
      print(data);
      return data.map((json) => TicketCategory.fromJson(json)).toList();
    } catch (e) {
      // Log hoặc return list rỗng để tránh crash
      return [];
    }
  }
}
