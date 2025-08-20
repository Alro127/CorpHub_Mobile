import 'package:http/http.dart' as http;
import 'package:ticket_helpdesk/config/ApiConfig.dart';
import 'dart:convert';

import 'package:ticket_helpdesk/domain/models/name_info.dart';

Future<List<NameInfo>> fetchUsersNameInfo() async {
  final response = await http.get(
    Uri.parse('${ApiConfig.baseUrl}/user/name-info'),
    headers: ApiConfig.headers,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    final List<dynamic> data = jsonResponse['data'];
    if (data.isEmpty) {
      return [];
    }

    return data.map((json) => NameInfo.fromJson(json)).toList();
  } else {
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    throw Exception('Failed to load tickets');
  }
}
