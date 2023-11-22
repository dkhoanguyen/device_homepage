import 'dart:async';
import 'dart:convert';
import 'package:device_homepage/models/hardware_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  static final WebSocketService _singleton = WebSocketService._internal();

  factory WebSocketService() {
    return _singleton;
  }

  WebSocketService._internal();

  WebSocketChannel? _channel;

  final _hardwareStatusController = StreamController<HardwareStatus>();

  Stream<HardwareStatus> get hardwareStatusStream =>
      _hardwareStatusController.stream;

  void connect(String serverAddress) {
    _channel = WebSocketChannel.connect(
        Uri.parse('ws://localhost:8080/api/v1/device/hardware-status'));
    _channel!.stream.listen(
      (data) {
        final jsonData = jsonDecode(data);
        final hardwareStatus = HardwareStatus.fromJson(jsonData);
        _hardwareStatusController.add(hardwareStatus);
      },
      onError: (error) {},
      onDone: () {},
    );
  }

  void close() {
    _channel?.sink.close(status.normalClosure);
  }
}

final hardwareStatusProvider = StreamProvider<HardwareStatus>((ref) {
  final webSocketService = ref.watch(webSocketServiceProvider);
  return webSocketService.hardwareStatusStream;
});

final webSocketServiceProvider = Provider<WebSocketService>((ref) {
  return WebSocketService()..connect('your_server_address:8080');
});
