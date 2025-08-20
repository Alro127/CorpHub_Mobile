import 'package:http/http.dart' as http;
import 'package:ticket_helpdesk/config/ApiConfig.dart';
import 'dart:convert';

import 'package:ticket_helpdesk/domain/dto/ticket_request.dart';
import 'package:ticket_helpdesk/domain/dto/ticket_response.dart';

Future<List<TicketResponse>> fetchTickets() async {
  final response = await http.get(
    Uri.parse('${ApiConfig.baseUrl}/tickets/get-all'),
    headers: ApiConfig.headers,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    final List<dynamic> data = jsonResponse['data'];
    if (data.isEmpty) {
      return [];
    }

    return data.map((json) => TicketResponse.fromJson(json)).toList();
  } else {
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    throw Exception('Failed to load tickets');
  }
}

Future<bool> createTicket(TicketRequest ticket) async {
  final response = await http.post(
    Uri.parse('${ApiConfig.baseUrl}/tickets/save'),
    headers: ApiConfig.headers,
    body: json.encode(ticket.toJson()),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    return false;
  }
}
