import 'package:device_homepage/constants.dart';
import 'package:device_homepage/responsive.dart';
import 'package:device_homepage/screens/dashboard/components/hardware_status.dart';
import 'package:device_homepage/services/websocket_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceHardwareStatus extends ConsumerWidget {
  const DeviceHardwareStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return ref.watch(hardwareStatusProvider).when(
        data: (hardwareStatusProvider) {
      return Container(
        padding: const EdgeInsets.all(defaultPadding),
        height: 140,
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white10)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  HardwareUsageBar(
                    name: "CPU Usage",
                    hardwareUsage: hardwareStatusProvider.cpuUsage / 100,
                    displayedText: Text(
                      '${(hardwareStatusProvider.cpuUsage).toStringAsFixed(2)}%',
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 10.0 : 12.0),
                    ),
                    widget: Image.asset(
                      "assets/images/cpu.png",
                      height: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  HardwareUsageBar(
                    name: "RAM Usage",
                    hardwareUsage: hardwareStatusProvider.memoryUsage / 100,
                    displayedText: Text(
                      '${(hardwareStatusProvider.cpuUsage).toStringAsFixed(2)}%',
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 10.0 : 12.0),
                    ),
                    widget: Image.asset(
                      "assets/images/ram-memory.png",
                      height: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                children: [
                  HardwareUsageBar(
                    name: "Storage",
                    hardwareUsage: hardwareStatusProvider.storageUsage / 100,
                    displayedText: Text(
                      '${(hardwareStatusProvider.cpuUsage).toStringAsFixed(2)}%',
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 10.0 : 12.0),
                    ),
                    widget: Image.asset(
                      "assets/images/database-storage.png",
                      height: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  HardwareUsageBar(
                    name: "Temperature",
                    hardwareUsage: hardwareStatusProvider.temperature / 100,
                    displayedText: Text(
                      (hardwareStatusProvider.cpuUsage).toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 10.0 : 12.0),
                    ),
                    widget: Image.asset(
                      "assets/images/thermometer.png",
                      height: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }, error: (hardwareStatusProvider, err) {
      return const SelectableText("Error");
    }, loading: () {
      return const Text("Loading device information...");
    });
  }
}
