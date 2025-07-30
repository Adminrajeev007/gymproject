import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000'; // Change to your deployed URL

  static Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Authentication
  static Future<Map<String, dynamic>> register(String username, String password, String name, String bio, String location) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/register'),
      headers: await _getHeaders(),
      body: json.encode({
        'username': username,
        'password': password,
        'name': name,
        'bio': bio,
        'location': location,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: await _getHeaders(),
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  // Gyms
  static Future<List<dynamic>> getGyms({String? query, double? lat, double? lng}) async {
    var uri = Uri.parse('$baseUrl/api/gyms');

    Map<String, String> queryParams = {};
    if (query != null && query.isNotEmpty) queryParams['search'] = query;
    if (lat != null) queryParams['lat'] = lat.toString();
    if (lng != null) queryParams['lng'] = lng.toString();

    if (queryParams.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParams);
    }

    final response = await http.get(uri, headers: await _getHeaders());

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch gyms: ${response.body}');
    }
  }

  static Future<List<dynamic>> getGymMembers(String gymId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/gyms/$gymId/members'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch gym members: ${response.body}');
    }
  }

  static Future<void> joinGym(String userId, String gymId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users/$userId/gyms'),
      headers: await _getHeaders(),
      body: json.encode({'gymId': gymId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to join gym: ${response.body}');
    }
  }

  // Chat
  static Future<List<dynamic>> getChats() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/chats'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch chats: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> createOrGetChat(String user1Id, String user2Id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/chats'),
      headers: await _getHeaders(),
      body: json.encode({
        'user1Id': user1Id,
        'user2Id': user2Id,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create chat: ${response.body}');
    }
  }

  static Future<List<dynamic>> getMessages(String chatId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/chats/$chatId/messages'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch messages: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> sendMessage(String chatId, String senderId, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/chats/$chatId/messages'),
      headers: await _getHeaders(),
      body: json.encode({
        'senderId': senderId,
        'content': content,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send message: ${response.body}');
    }
  }
}