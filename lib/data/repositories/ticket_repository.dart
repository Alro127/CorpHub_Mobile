import 'package:ticket_helpdesk/data/api_service.dart';
import 'package:ticket_helpdesk/domain/dto/ticket_request.dart';
import 'package:ticket_helpdesk/domain/dto/ticket_response.dart';
import 'package:ticket_helpdesk/domain/models/ticket_category.dart';

class TicketRepository {
  Future<List<TicketResponse>> fetchTickets() async {
    final jsonResponse = await ApiService.get('/tickets/get-all');
    final List<dynamic> data = jsonResponse['data'] ?? [];
    return data.map((json) => TicketResponse.fromJson(json)).toList();
  }

  Future<bool> saveTicket(TicketRequest ticket) async {
    await ApiService.post('/tickets/save', ticket.toJson());
    return true;
  }

  Future<bool> deleteTicket(int id) async {
    await ApiService.delete('/tickets/delete/$id');
    return true;
  }
  Future<List<TicketCategory>> fetchCategories() async {
    try {
      final response = await ApiService.get("/tickets/categories");
      final List<dynamic> data = response['data'] ?? [];
      return data.map((json) => TicketCategory.fromJson(json)).toList();
    } catch (e) {
      // có thể log hoặc return list rỗng thay vì throw để tránh crash
      rethrow;
    }
  }
}
