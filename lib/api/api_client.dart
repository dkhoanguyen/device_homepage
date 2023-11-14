import 'dart:convert';
import 'package:device_homepage/models/device_info.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const baseUrl = 'http://0.0.0.0:8080';
  final http.Client httpClient;
  final dynamic apiKey;

  ApiClient({required this.httpClient, this.apiKey}) : assert(apiKey != null);

  Future<DeviceInfo> getDeviceInfo() async {
    final response = await http
        .get(Uri.parse("http://0.0.0.0:8080/api/v1/watchtower/device-info"));
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return DeviceInfo.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to GET device-info.');
    }
  }
}
