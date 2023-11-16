import 'package:device_homepage/constants.dart';
import 'package:device_homepage/responsive.dart';
import 'package:device_homepage/screens/dashboard/components/device_hardware_status.dart';
import 'package:device_homepage/screens/dashboard/components/device_headline.dart';
import 'package:device_homepage/screens/dashboard/components/device_info_card.dart';
import 'package:device_homepage/screens/dashboard/components/header.dart';
import 'package:device_homepage/screens/dashboard/components/logs_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 500,
                        child: Container(
                          padding: const EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.white10)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const DeviceHeadline(
                                    nameTitle: "robotics_default",
                                    actionButtonTitle: "Actions"),
                                const Padding(
                                  padding: EdgeInsets.all(defaultPadding / 2),
                                  child: Divider(
                                    color: Colors.white24,
                                    thickness: 2,
                                  ),
                                ),
                                Expanded(
                                    child: LayoutBuilder(
                                  builder: (context, constraints) =>
                                      DeviceInfoCardGridView(
                                    boxConstraints: constraints,
                                  ),
                                )),
                              ]),
                        ),
                      ),
                      if (Responsive.isMobile(context))
                        const SizedBox(
                          height: defaultPadding,
                        ),
                      if (Responsive.isMobile(context))
                        const DeviceHardwareStatus(),
                      if (Responsive.isMobile(context))
                        const SizedBox(
                          height: defaultPadding,
                        ),
                      if (Responsive.isMobile(context)) const LogsViewer(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(
                    width: defaultPadding,
                  ),
                if (!Responsive.isMobile(context))
                  const Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          DeviceHardwareStatus(),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          LogsViewer(),
                        ],
                      ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
