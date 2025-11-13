import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class ApiConfig {
  static String get baseUrl {
    const fromEnv = String.fromEnvironment('API_BASE_URL');
    if (fromEnv.isNotEmpty) return _trimTrailingSlash(fromEnv);
    if (kIsWeb) return 'http://localhost:3000';
    if (Platform.isAndroid) return 'http://10.0.2.2:3000';
    return 'http://localhost:3000';
  }

  static Uri url(String path, [Map<String, dynamic>? query]) {
    final normalized = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$baseUrl$normalized').replace(queryParameters: query);
  }

  static String _trimTrailingSlash(String v) {
    return v.endsWith('/') ? v.substring(0, v.length - 1) : v;
  }
}


