import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ticket_helpdesk/domain/models/ticket.dart';

Future<List<Ticket>> fetchTickets() async {
  final response = await http.get(
    Uri.parse(
      'http://10.0.2.2:3000/api/tickets/get-all-tickets',
    ), // Thay <IP_BACKEND> bằng IP backend của bạn
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Ticket.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load tickets');
  }
}
