import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/data/dto/ticket_response.dart';
import 'package:ticket_helpdesk/domain/usecases/ticket_usecases.dart';

class MyTicketsViewModel extends ChangeNotifier {
  final TicketUseCase _ticketUseCase;

  MyTicketsViewModel({required TicketUseCase ticketUseCase})
    : _ticketUseCase = ticketUseCase {
    fetchTickets();
  }

  List<TicketResponse> tickets = [];
  bool isLoading = true;
  String? errorMessage;
  final int _currentUserId = 1; // Giả sử user hiện tại có ID là 1

  int get currentUserId => _currentUserId;

  /// Search
  String searchText = '';

  Future<void> fetchTickets() async {
    isLoading = true;
    notifyListeners();
    try {
      print("Fetching tickets...");
      tickets = await _ticketUseCase.fetchTickets();
      print(" Fetched ${tickets.length} tickets.");
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteTicket(int ticketId) async {
    try {
      final success = await _ticketUseCase.deleteTicket(ticketId);
      if (success) {
        tickets.removeWhere((ticket) => ticket.id == ticketId);
        notifyListeners();
      }
      return success;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void setSearchText(String text) {
    searchText = text;
    notifyListeners();
  }

  List<TicketResponse> get filteredTickets {
    if (searchText.isEmpty) return tickets;
    return tickets
        .where((t) => t.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }
}
