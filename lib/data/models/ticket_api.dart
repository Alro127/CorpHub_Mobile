import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ticket_helpdesk/domain/models/ticket.dart';

Future<List<Ticket>> fetchTickets() async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:3000/api/tickets/get-all-tickets'),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Ticket.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load tickets');
  }
}

Future<bool> createTicket(Ticket ticket) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/api/tickets/add-or-update-ticket'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(ticket.toJson()),
  );
  return response.statusCode == 200 || response.statusCode == 201;
}
