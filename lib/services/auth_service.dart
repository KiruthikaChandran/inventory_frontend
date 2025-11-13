import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_client.dart';

class AuthService {
  final ApiClient _api = ApiClient();

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final res = await _api.post('/user/signin', {
      'email': email,
      'password': password,
    });
    // Persist user object (no JWT in backend)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(res));
    return Map<String, dynamic>.from(res);
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final res = await _api.post('/user/register', {
      'email': email,
      'password': password,
    });
    return Map<String, dynamic>.from(res);
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  Future<Map<String, dynamic>?> currentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('user');
    if (raw == null) return null;
    return Map<String, dynamic>.from(jsonDecode(raw));
  }
}



