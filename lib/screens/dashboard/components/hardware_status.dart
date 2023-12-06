import 'package:device_homepage/responsive.dart';
import 'package:flutter/material.dart';

class HardwareUsageBar extends StatelessWidget {
  final double hardwareUsage;
  final String name;
  final Text displayedText;
  Widget? widget;

  HardwareUsageBar(
      {super.key,
      required this.hardwareUsage,
      required this.name,
      required this.displayedText,
      this.widget});

  Color _progressBarColor(double value) {
    if (value >= 0.7) {
      return const Color.fromRGBO(244, 67, 54, 1);
    } else if (value > 0.5 && value < 0.7) {
      return const Color.fromARGB(255, 244, 216, 54);
    }
    return const Color.fromRGBO(76, 175, 80, 1);
  }

  @override
  Widget build(BuildContext context) {
    Color progressBarColor = _progressBarColor(hardwareUsage);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: Responsive.isMobile(context) ? 10.0 : 12.0),
                ),
                const SizedBox(width: 5),
                // (widget != null) ? widget! : Container(),
              ],
            ),
            displayedText,
          ],
        ),
        const SizedBox(height: 10.0),
        LinearProgressIndicator(
          color: const Color.fromRGBO(76, 175, 80, 1),
          backgroundColor: const Color.fromARGB(255, 222, 222, 222),
          value: hardwareUsage, // Set the progress value
          minHeight: 16.0,
          borderRadius: BorderRadius.circular(3),
          valueColor: AlwaysStoppedAnimation<Color>(progressBarColor),
        ),
      ],
    );
  }
}
