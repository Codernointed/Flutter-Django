import 'dart:convert';
import 'package:http/http.dart';

class AuthClient {
  final String _apiUrl =
      'https://ethenatx.pythonanywhere.com/management/obtain-token/';

  Future<String> login(String email, String password) async {
    final response = await post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Login failed: ${response.statusCode}');
    }

    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse['access'];
  }
}
