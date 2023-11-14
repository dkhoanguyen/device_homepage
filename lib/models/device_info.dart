class DeviceInfo {
  final String status;
  final String uuid;
  final String deviceType;
  final int onlineDuration;
  final String osType;
  final int deviceState;
  final int internetStatus;

  const DeviceInfo(
      {required this.status,
      required this.uuid,
      required this.deviceType,
      required this.onlineDuration,
      required this.osType,
      required this.deviceState,
      required this.internetStatus});

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
        status: json['status'] as String,
        uuid: json['uuid'] as String,
        deviceType: json['device_type'] as String,
        onlineDuration: json['online_duration'] as int,
        osType: json['os_type'] as String,
        deviceState: json['device_state'] as int,
        internetStatus: json['internet_status'] as int);
  }
}
