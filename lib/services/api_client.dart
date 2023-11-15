import 'dart:convert';
import 'package:device_homepage/models/device_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class DeviceApiClient {
  static const baseUrl = 'http://0.0.0.0:8080';

  DeviceApiClient();

  Future<DeviceInfo> getDeviceInfo() async {
    try {
      final Map<String, String> headers = {
        'Authorization':
            'Bearer robotics', // Include your access token or any other headers
      };
      final response = await http.get(
          Uri.parse("http://0.0.0.0:8080/api/v1/watchtower/device-info"),
          headers: headers);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return DeviceInfo.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to GET device-info.');
      }
    } catch (e) {
      // Handle network and other errors
      print('Error: $e');
      return const DeviceInfo(
        status: "1",
        uuid: "1",
        deviceType: "1",
        onlineDuration: 1,
        osType: "1",
        deviceRole: "1",
        internetStatus: "1",
        supervisorRelease: "1",
      );
    }
  }
}

final deviceClientProvider = Provider((ref) => DeviceApiClient());

final deviceDataProvider = FutureProvider<DeviceInfo>((ref) async {
  return ref.read(deviceClientProvider).getDeviceInfo();
});
