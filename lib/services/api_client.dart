import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiClient {
  final http.Client _client;
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Map<String, String> _jsonHeaders([Map<String, String>? extra]) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?extra,
    };
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    final uri = ApiConfig.url(path, query);
    final res = await _client.get(uri, headers: _jsonHeaders());
    return _handle(res);
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final uri = ApiConfig.url(path);
    final res = await _client.post(uri, headers: _jsonHeaders(), body: jsonEncode(body));
    return _handle(res);
  }

  Future<dynamic> put(String path, Map<String, dynamic> body) async {
    final uri = ApiConfig.url(path);
    final res = await _client.put(uri, headers: _jsonHeaders(), body: jsonEncode(body));
    return _handle(res);
  }

  Future<dynamic> delete(String path) async {
    final uri = ApiConfig.url(path);
    final res = await _client.delete(uri, headers: _jsonHeaders());
    return _handle(res);
  }

  dynamic _handle(http.Response res) {
    try {
      final dynamic decoded = res.body.isEmpty ? null : jsonDecode(res.body);
      if (res.statusCode >= 200 && res.statusCode < 300) return decoded;
      
      String message = 'Request failed';
      if (decoded is Map) {
        if (decoded['error'] != null) {
          message = decoded['error'].toString();
        } else if (decoded['message'] != null) {
          message = decoded['message'].toString();
        } else {
          message = 'Request failed with status ${res.statusCode}';
        }
      } else {
        message = 'Request failed with status ${res.statusCode}';
      }
      
      throw Exception(message);
    } catch (e) {
      if (e is Exception) rethrow;
      // Handle JSON decode errors
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return null;
      }
      throw Exception('Failed to connect to server. Please check if the backend is running.');
    }
  }
}



