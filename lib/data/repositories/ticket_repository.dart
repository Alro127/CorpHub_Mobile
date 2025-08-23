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
      final jsonResponse = await api.get('/tickets/get-all');
      final List<dynamic> data = jsonResponse?['data'] ?? [];
      return data.map((json) => TicketResponse.fromJson(json)).toList();
    } catch (e) {
      // Log hoặc throw tiếp nếu muốn ViewModel xử lý
      rethrow;
    }
  }

  Future<bool> saveTicket(TicketRequest ticket) async {
    try {
      await api.post('/tickets/save', ticket.toJson());
      return true;
    } catch (e) {
      // Log hoặc xử lý lỗi
      return false;
    }
  }

  Future<bool> deleteTicket(int id) async {
    try {
      await api.delete('/tickets/delete/$id');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<TicketCategory>> fetchCategories() async {
    try {
      final response = await api.get('/tickets/categories');
      final List<dynamic> data = response?['data'] ?? [];
      return data.map((json) => TicketCategory.fromJson(json)).toList();
    } catch (e) {
      // Log hoặc return list rỗng để tránh crash
      return [];
    }
  }
}
