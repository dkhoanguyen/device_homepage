import 'package:device_homepage/constants.dart';
import 'package:device_homepage/screens/dashboard/components/chart.dart';
import 'package:device_homepage/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    height: 500,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.white10)),
                    child: Column(children: [
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
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: defaultPadding / 2),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: defaultPadding / 2),
                                      child: Text("Online"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "UUID",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: defaultPadding / 2),
                                SelectableText(" default",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "OS Type",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: defaultPadding / 2),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/Raspberry_Pi_Logo.svg",
                                      width: 20,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: defaultPadding),
                                      child: Text("Raspbian Buster"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    height: 500,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.white10)),
                    child: Column(
                      children: [
                        const Text("Storage Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        const Chart(),
                        const SizedBox(height: defaultPadding),
                        Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: primaryColor.withOpacity(0.15)),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(defaultPadding)),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceHeadline extends StatelessWidget {
  const DeviceHeadline(
      {Key? key, required this.nameTitle, required this.actionButtonTitle})
      : super(key: key);

  final String nameTitle, actionButtonTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          nameTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ElevatedButton.icon(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(defaultPadding)),
          onPressed: () {},
          icon: const Icon(Icons.construction_outlined),
          label: Text(
            actionButtonTitle,
          ),
        )
      ],
    );
  }
}
