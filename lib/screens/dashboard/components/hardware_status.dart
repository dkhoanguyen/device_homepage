import 'package:flutter/material.dart';

class HardwareUsageBar extends StatelessWidget {
  final double hardwareUsage;
  final String name;
  const HardwareUsageBar(
      {super.key, required this.hardwareUsage, required this.name});

  @override
  Widget build(BuildContext context) {
    Color progressBarColor = hardwareUsage > 0.5
        ? const Color.fromRGBO(244, 67, 54, 1)
        : const Color.fromRGBO(76, 175, 80, 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              '${(hardwareUsage * 100).toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        LinearProgressIndicator(
          color: const Color.fromRGBO(76, 175, 80, 1),
          value: hardwareUsage, // Set the progress value
          minHeight: 12.0,
          borderRadius: BorderRadius.circular(3),
          valueColor: AlwaysStoppedAnimation<Color>(progressBarColor),
        ),
      ],
    );
  }
}
