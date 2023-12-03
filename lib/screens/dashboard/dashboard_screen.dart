import 'package:device_homepage/constants.dart';
import 'package:device_homepage/responsive.dart';
import 'package:device_homepage/screens/dashboard/components/device_hardware_status.dart';
import 'package:device_homepage/screens/dashboard/components/device_highlights.dart';
import 'package:device_homepage/screens/dashboard/components/header.dart';
import 'package:device_homepage/screens/dashboard/components/logs_viewer.dart';
import 'package:device_homepage/screens/dashboard/components/service_card.dart';
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
            const DeviceDashboardHeader(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const DeviceHighlights(),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      const ControllerDashboard(),
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
                      if (Responsive.isMobile(context)) LogsViewer(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(
                    width: defaultPadding,
                  ),
                if (!Responsive.isMobile(context))
                  Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          const DeviceHardwareStatus(),
                          const SizedBox(
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

class ControllerDashboard extends StatelessWidget {
  const ControllerDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 433,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white)),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Padding(
                padding: EdgeInsets.all(defaultPadding / 2),
                child: Text(
                  "Services",
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.play_arrow,
                        size: 20.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.pause,
                        size: 20.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.stop,
                        size: 20.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.restart_alt,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(
              height: defaultPadding,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const ServiceCardWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.title!)),
      DataCell(Text(fileInfo.date!)),
      DataCell(
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.play_arrow,
                size: 20.0,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.pause,
                size: 20.0,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.stop,
                size: 20.0,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.restart_alt,
                size: 20.0,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.document_scanner,
                size: 20.0,
              ),
            )
          ],
        ),
      ),
    ],
  );
}

class RecentFile {
  final String? icon, title, date, size;

  RecentFile({this.icon, this.title, this.date, this.size});
}

List demoRecentFiles = [
  RecentFile(
    icon: "assets/icons/xd_file.svg",
    title: "XD File",
    date: "01-03-2021",
    size: "3.5mb",
  ),
  RecentFile(
    icon: "assets/icons/Figma_file.svg",
    title: "Figma File",
    date: "27-02-2021",
    size: "19.0mb",
  ),
  RecentFile(
    icon: "assets/icons/doc_file.svg",
    title: "Document",
    date: "23-02-2021",
    size: "32.5mb",
  ),
  RecentFile(
    icon: "assets/icons/sound_file.svg",
    title: "Sound File",
    date: "21-02-2021",
    size: "3.5mb",
  ),
  RecentFile(
    icon: "assets/icons/media_file.svg",
    title: "Media File",
    date: "23-02-2021",
    size: "2.5gb",
  ),
  RecentFile(
    icon: "assets/icons/pdf_file.svg",
    title: "Sales PDF",
    date: "25-02-2021",
    size: "3.5mb",
  ),
  RecentFile(
    icon: "assets/icons/excel_file.svg",
    title: "Excel File",
    date: "25-02-2021",
    size: "34.5mb",
  ),
];
