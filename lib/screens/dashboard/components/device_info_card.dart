import 'package:device_homepage/constants.dart';
import 'package:device_homepage/models/device_info.dart';
import 'package:device_homepage/responsive.dart';
import 'package:device_homepage/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class DeviceInfoCell {
  final Icon? icon;
  final SvgPicture? image;
  final String? title;
  final String? info;
  final bool? wrapText;
  DeviceInfoCell({this.title, this.info, this.icon, this.image, this.wrapText});
}

class DeviceInfoCardBuilder {
  final DeviceInfo deviceInfo;

  DeviceInfoCardBuilder({required this.deviceInfo});

  List<DeviceInfoCell> build() {
    return [
      DeviceInfoCell(
          title: "Status",
          info: deviceInfo.status,
          icon: const Icon(
            Icons.check,
            color: Colors.green,
            size: 20,
          )),
      DeviceInfoCell(title: "UUID", info: deviceInfo.uuid),
      DeviceInfoCell(
          title: "Type",
          info: deviceInfo.deviceType,
          image: SvgPicture.asset(
            "assets/icons/Raspberry_Pi_Logo.svg",
            height: 20,
          )),
      DeviceInfoCell(
          title: "Last Online", info: "${deviceInfo.onlineDuration} hours"),
      DeviceInfoCell(title: "OS Type", info: deviceInfo.osType),
      DeviceInfoCell(
          title: "Device State", info: deviceInfo.deviceRole, wrapText: true),
      DeviceInfoCell(
          title: "Internet Access",
          info: deviceInfo.internetStatus,
          icon: (deviceInfo.internetStatus == "Connected")
              ? const Icon(
                  Icons.cloud_done_outlined,
                  color: Colors.green,
                  size: 20,
                )
              : const Icon(
                  Icons.cloud_off,
                  color: Colors.red,
                  size: 20,
                )),
      DeviceInfoCell(
          title: "Update Status",
          info: "Up to date",
          icon: const Icon(
            Icons.check,
            color: Colors.green,
            size: 20,
          )),
      DeviceInfoCell(title: "Supervior Release", info: "Test"),
    ];
  }
}

class DeviceInfoCard extends StatelessWidget {
  const DeviceInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final DeviceInfoCell info;

  double _adaptiveFontSize(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (Responsive.isDesktop(context)) {
      if (size.width > 1200) return 13;
      return 12;
    }
    if (size.width >= 920) {
      return 13;
    } else if (size.width > 764 && size.width < 920) {
      return 10;
    }
    if (size.width >= 500 && MediaQuery.of(context).size.width <= 764) {
      return 13;
    } else if (size.width < 500 && size.width >= 425) return 12;
    return 11;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          info.title!,
          style: TextStyle(
              fontSize: _adaptiveFontSize(context),
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (info.icon != null) info.icon!,
            if (info.image != null) info.image!,
            if (info.icon != null || info.image != null)
              const SizedBox(width: 5),
            (info.wrapText != null && info.wrapText == true)
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.white10)),
                    child: Text(
                      info.info!,
                      style: TextStyle(
                          fontSize: _adaptiveFontSize(context),
                          fontWeight: FontWeight.w100),
                    ),
                  )
                : Text(
                    info.info!,
                    style: TextStyle(
                        fontSize: _adaptiveFontSize(context),
                        fontWeight: FontWeight.w100),
                  ),
          ],
        ),
      ]),
    );
  }
}

class DeviceInfoCardGridView extends ConsumerWidget {
  const DeviceInfoCardGridView({Key? key, required this.boxConstraints})
      : super(key: key);
  final BoxConstraints boxConstraints;

  double _childAspectRatio(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (Responsive.isDesktop(context)) {
      return boxConstraints.maxWidth / 200;
    }
    if (size.width >= 500) {
      return boxConstraints.maxWidth / 170;
    } else if (size.width >= 450 && MediaQuery.of(context).size.width < 500) {
      return boxConstraints.maxWidth / 150;
    }
    return boxConstraints.maxWidth / 110;
  }

  @override
  Widget build(BuildContext context, ref) {
    final Size size = MediaQuery.of(context).size;
    return ref.watch(deviceDataProvider).when(data: (deviceDataProvider) {
      final deviceInfoList =
          DeviceInfoCardBuilder(deviceInfo: deviceDataProvider).build();
      return GridView.builder(
        shrinkWrap: true,
        itemCount: deviceInfoList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: size.width < 500 ? 2 : 3,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
            childAspectRatio: _childAspectRatio(context)),
        itemBuilder: (context, index) =>
            DeviceInfoCard(info: deviceInfoList[index]),
      );
    }, error: (deviceDataProvider, err) {
      return SelectableText("Error: $err");
    }, loading: () {
      return const Text("Loading device information...");
    });
  }
}
