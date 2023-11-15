class DeviceInfo {
  final String status;
  final String uuid;
  final String deviceType;
  final int onlineDuration;
  final String osType;
  final String deviceRole;
  final String internetStatus;
  final String supervisorRelease;

  const DeviceInfo(
      {required this.status,
      required this.uuid,
      required this.deviceType,
      required this.onlineDuration,
      required this.osType,
      required this.deviceRole,
      required this.internetStatus,
      required this.supervisorRelease});

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
        status: json['status'] as String,
        uuid: json['uuid'] as String,
        deviceType: json['device_type'] as String,
        onlineDuration: json['online_duration'] as int,
        osType: json['os_type'] as String,
        deviceRole: json['device_role'] as String,
        internetStatus: json['internet_status'] as String,
        supervisorRelease: json['supervisor_release'] as String);
  }
}
