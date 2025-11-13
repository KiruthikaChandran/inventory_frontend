class ApiConfig {
  static String get baseUrl => 'http://192.168.201.71:3000'; // 👈 your PC IPv4

  static Uri url(String path, [Map<String, dynamic>? query]) {
    final normalized = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$baseUrl$normalized').replace(queryParameters: query);
  }
}
