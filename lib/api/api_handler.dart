import 'dart:convert';
import 'package:dio/dio.dart';

class ApiHandler {
  static const String baseUrl = 'http://0.0.0.0:8080';

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  static Future<Map<String, dynamic>> fetchData(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      if (response.statusCode == 200) {
        return json.decode(response.toString());
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to make the request: $e');
    }
  }
}
