class ApiConfig {
  static String get baseUrl => 'http://desktop-eg91ltq.local:3000'; // same as backend IP

  static Uri url(String path, [Map<String, dynamic>? query]) {
    final normalized = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$baseUrl$normalized').replace(queryParameters: query);
  }
}
