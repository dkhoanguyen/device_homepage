class HardwareStatus {
  final double cpuUsage;
  final double memoryUsage;
  final double storageUsage;
  final double temperature;

  const HardwareStatus(
      {required this.cpuUsage,
      required this.memoryUsage,
      required this.storageUsage,
      required this.temperature});

  factory HardwareStatus.fromJson(Map<String, dynamic> json) {
    return HardwareStatus(
        cpuUsage: json['cpu'] as double,
        memoryUsage: json['ram'] as double,
        storageUsage: json['storage'] as double,
        temperature: json['temperature'] as double);
  }
}
