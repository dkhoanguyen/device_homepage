import 'dart:convert';
import 'package:device_homepage/models/device_info.dart';
import 'package:device_homepage/models/hardware_status.dart';
import 'package:device_homepage/screens/dashboard/components/logs_viewer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class DeviceApiClient {
  static const baseUrl = 'http://localhost:8080';

  String _containerName = "watchtower";

  DeviceApiClient();

  void setContainerName(String name) {
    _containerName = name;
  }

  Future<DeviceInfo> getDeviceInfo() async {
    try {
      final Map<String, String> headers = {
        'Authorization': 'Bearer robotics',
        "Content-Type":
            "application/json" // Include your access token or any other headers
      };
      final response = await http.get(
          Uri.parse("http://localhost:8080/api/v1/device/info"),
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
          Uri.parse("http://localhost:8080/api/v1/watchtower/hardware-status"),
          headers: headers);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return HardwareStatus.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to GET device-info.');
      }
    } catch (e) {
      // Handle network and other errors
      return const HardwareStatus(
        cpuUsage: 0.0,
        memoryUsage: 0.0,
        temperature: 0.0,
        storageUsage: 0.0,
      );
    }
  }

  Future<String> getLogs() async {
    try {
      final Map<String, String> headers = {
        'Authorization':
            'Bearer robotics', // Include your access token or any other headers
      };
      final response = await http.get(
          Uri.parse(
              "http://localhost:8080/api/v1/watchtower/logs?container=$_containerName"),
          headers: headers);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to GET device-info.');
      }
    } catch (e) {
      // Handle network and other errors
      return "";
    }
  }
}

final deviceClientProvider = Provider((ref) => DeviceApiClient());

final deviceDataProvider = FutureProvider<DeviceInfo>((ref) async {
  return ref.read(deviceClientProvider).getDeviceInfo();
});

final containerLogsProvider = FutureProvider<String>((ref) async {
  // logContent.setToBottom(true);
  return ref.read(deviceClientProvider).getLogs();
});

final containerLogsStreamProvider =
    StreamProvider.autoDispose<String>((ref) async* {
  while (true) {
    yield await ref.read(deviceClientProvider).getLogs();
    await Future.delayed(const Duration(milliseconds: 1000));
    logContent.setToBottom(true);
  }
});

final webSocketProvider = Provider<WebSocketChannel>((ref) {
  return WebSocketChannel.connect(Uri.parse(''));
});

final systemResourcesProvider = StreamProvider<HardwareStatus>((ref) {
  final webSocket = ref.watch(webSocketProvider);
  return webSocket.stream.map((dynamic data) {
    final Map<String, dynamic> jsonData = data as Map<String, dynamic>;
    return HardwareStatus.fromJson(jsonData);
  });
});
