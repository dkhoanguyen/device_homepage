import 'dart:convert';
import 'package:device_homepage/models/device_info.dart';
import 'package:device_homepage/models/hardware_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

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
          Uri.parse("http://0.0.0.0:8080/api/v1/device/info"),
          headers: headers);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return DeviceInfo.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to GET device-info.');
      }
    } catch (e) {
      // Handle network and other errors
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

  Future<HardwareStatus> getHardwareStatus() async {
    try {
      final Map<String, String> headers = {
        'Authorization':
            'Bearer robotics', // Include your access token or any other headers
      };
      final response = await http.get(
          Uri.parse("http://0.0.0.0:8080/api/v1/watchtower/hardware-status"),
          headers: headers);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return HardwareStatus.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to GET device-info.');
      }
    } catch (e) {
      // Handle network and other errors
      print('Error: $e');
      return const HardwareStatus(
        cpuUsage: 0.0,
        memoryUsage: 0.0,
        temperature: 0.0,
        storageUsage: 0.0,
      );
    }
  }
}

final deviceClientProvider = Provider((ref) => DeviceApiClient());

final deviceDataProvider = FutureProvider<DeviceInfo>((ref) async {
  return ref.read(deviceClientProvider).getDeviceInfo();
});

// final hardwareStatusProvider = StreamProvider<HardwareStatus>((ref) async* {
//   while (true) {
//     final response = await http.get(Uri.parse('YOUR_BACKEND_API_ENDPOINT'));

//     if (response.statusCode == 200) {
//       yield HardwareStatus.fromJson(
//           jsonDecode(response.body) as Map<String, dynamic>);
//     } else {
//       // Handle error
//       print('Failed to load CPU usage data');
//     }

//     // Wait for 1 minute before fetching again
//     await Future.delayed(const Duration(minutes: 1));
//   }
// });

final webSocketProvider = Provider<WebSocketChannel>((ref) {
  return WebSocketChannel.connect(
      Uri.parse('ws://your_server_address:8080/ws'));
});

final systemResourcesProvider = StreamProvider<HardwareStatus>((ref) {
  final webSocket = ref.watch(webSocketProvider);
  return webSocket.stream.map((dynamic data) {
    final Map<String, dynamic> jsonData = data as Map<String, dynamic>;
    return HardwareStatus.fromJson(jsonData);
  });
});
