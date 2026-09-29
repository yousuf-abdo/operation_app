import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:operation_app/core/functaions/secure_storage.dart';

class ApiClient {
  // static const String baseUrl = 'http://10.73.136.183:5137/api';
  static const String baseUrl = 'http://localhost:5137/api';

  // دالة مساعدة لبناء الترويسات
  static Future<Map<String, String>> _buildHeaders(bool authenticated) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (authenticated) {
      final token = await SecureStorage.getToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  // POST
  static Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    bool authenticated = false,
  }) async {
    final headers = await _buildHeaders(authenticated);
    return await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body ?? {}),
    );
  }

  // GET
  static Future<http.Response> get(
    String endpoint, {
    bool authenticated = false,
  }) async {
    final headers = await _buildHeaders(authenticated);
    return await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
  }

  // PUT
  static Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? body,
    bool authenticated = false,
  }) async {
    final headers = await _buildHeaders(authenticated);
    return await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body ?? {}),
    );
  }

  // DELETE
  static Future<http.Response> delete(
    String endpoint, {
    bool authenticated = false,
  }) async {
    final headers = await _buildHeaders(authenticated);
    return await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);
  }
}
