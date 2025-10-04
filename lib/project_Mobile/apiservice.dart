import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Login successful, store the token
      final data = jsonDecode(response.body);
      final token =
          data['token']; // Assuming 'token' is the key returned by the server

      // You can store the token locally using SharedPreferences or any secure storage mechanism
      // Example with SharedPreferences:
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      return true; // Login successful
    } else {
      print('Login failed: ${response.body}');
      return false; // Login failed
    }
  }

  Future<bool> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return true; // Registration successful
    } else if (response.statusCode == 409) {
      print('Username already exists');
    } else {
      print('Registration failed: ${response.body}');
    }

    return false; // Registration failed
  }
}
