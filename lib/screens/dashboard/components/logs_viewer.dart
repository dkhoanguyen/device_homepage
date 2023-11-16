import 'package:device_homepage/constants.dart';
import 'package:flutter/material.dart';

class LogsViewer extends StatelessWidget {
  const LogsViewer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      height: 365 - defaultPadding,
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10)),
    );
  }
}
