import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class UserService {
  final http.Client client;

  UserService({http.Client? client}) : client = client ?? http.Client();

  Future<List<User>> fetchUsers(String accessToken) async {
    final uri = Uri.parse('http://[::1]:3000/users');
    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> updateUserRole(
      String accessToken, String email, String newRole) async {
    final uri = Uri.parse('http://[::1]:3000/users/update-role');
    final response = await client.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({'email': email, 'role': newRole}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user role');
    }
  }
}
