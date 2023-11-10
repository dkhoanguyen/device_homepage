import 'package:device_homepage/constants.dart';
import 'package:device_homepage/responsive.dart';
import 'package:device_homepage/screens/dashboard/components/chart.dart';
import 'package:device_homepage/screens/dashboard/components/device_headline.dart';
import 'package:device_homepage/screens/dashboard/components/device_info_card.dart';
import 'package:device_homepage/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultPadding),
            Row(
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
                        const DeviceHardwareStatus()
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(
                    width: defaultPadding,
                  ),
                if (!Responsive.isMobile(context))
                  const Expanded(flex: 2, child: DeviceHardwareStatus())
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceHardwareStatus extends StatelessWidget {
  const DeviceHardwareStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      height: 500,
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10)),
      child: Column(
        children: [
          const Text("Storage Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          const Chart(),
          const SizedBox(height: defaultPadding),
          Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                border:
                    Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
                borderRadius:
                    const BorderRadius.all(Radius.circular(defaultPadding)),
              )),
        ],
      ),
    );
  }
}
