import 'package:device_homepage/constants.dart';
import 'package:device_homepage/screens/dashboard/components/hardware_status.dart';
import 'package:flutter/material.dart';

class DeviceHardwareStatus extends StatelessWidget {
  const DeviceHardwareStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      height: 135,
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10)),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              children: [
                CpuUsageGraph(),
                SizedBox(
                  height: 16,
                ),
                CpuUsageGraph(),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              children: [
                CpuUsageGraph(),
                SizedBox(
                  height: 16,
                ),
                CpuUsageGraph(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
