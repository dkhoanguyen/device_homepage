import 'package:device_homepage/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: 3,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: defaultPadding,
        ),
        itemBuilder: ((context, index) => Container()));
  }
}

class DeviceInfo {
  final Icon? icon;
  final SvgPicture? image;
  final String? title;
  final String? info;
  DeviceInfo({this.title, this.info, this.icon, this.image});
}

List deviceInfoList = [
  DeviceInfo(
      title: "Status",
      info: "Online",
      icon: const Icon(
        Icons.check,
        color: Colors.green,
        size: 20,
      )),
  DeviceInfo(title: "UUID", info: "defaults"),
  DeviceInfo(
      title: "Type",
      info: "Raspberry Pi 4",
      image: SvgPicture.asset(
        "assets/icons/Raspberry_Pi_Logo.svg",
        height: 20,
      )),
  DeviceInfo(title: "Last Online", info: "2 hours"),
  DeviceInfo(title: "OS Type", info: "Raspbian"),
  DeviceInfo(title: "Device State", info: "development"),
  DeviceInfo(
      title: "Internet Access",
      info: "Offline",
      icon: const Icon(
        Icons.cloud_off,
        color: Colors.red,
        size: 20,
      )),
  DeviceInfo(
      title: "Update Status",
      info: "Up to date",
      icon: const Icon(
        Icons.check,
        color: Colors.green,
        size: 20,
      )),
  DeviceInfo(title: "Fleet", info: "UTS RI"),
];

class DeviceInfoCard extends StatelessWidget {
  const DeviceInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final DeviceInfo info;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          info.title!,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (info.icon != null) info.icon!,
            if (info.image != null) info.image!,
            if (info.icon != null || info.image != null)
              const SizedBox(width: 5),
            Text(
              info.info!,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w100),
            ),
          ],
        ),
      ]),
    );
  }
}

class DeviceInfoCardGridView extends StatelessWidget {
  const DeviceInfoCardGridView(
      {Key? key,
      this.crossAxisCount = 3,
      this.childAspectRatio = 3,
      required this.boxConstraints})
      : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final BoxConstraints boxConstraints;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GridView.builder(
      shrinkWrap: true,
      itemCount: deviceInfoList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: size.width < 500 ? 2 : 3,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: boxConstraints.maxWidth / 200,
      ),
      itemBuilder: (context, index) =>
          DeviceInfoCard(info: deviceInfoList[index]),
    );
  }
}
