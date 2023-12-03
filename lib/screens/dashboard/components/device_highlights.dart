import 'package:device_homepage/constants.dart';
import 'package:device_homepage/screens/dashboard/components/device_headline.dart';
import 'package:device_homepage/screens/dashboard/components/device_info_card.dart';
import 'package:flutter/material.dart';

class DeviceHighlights extends StatelessWidget {
  const DeviceHighlights({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 416,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const DeviceHeadline(
              nameTitle: "robotics_default", actionButtonTitle: "Actions"),
          const Padding(
            padding: EdgeInsets.all(defaultPadding / 2),
            child: Divider(
              color: Colors.black87,
              thickness: 2,
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => DeviceInfoCardGridView(
                boxConstraints: constraints,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
