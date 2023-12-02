import 'package:device_homepage/responsive.dart';
import 'package:device_homepage/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_homepage/screens/side_menu/side_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              flex: 1,
              child: SideMenu(),
            ),
          Expanded(
              flex: MediaQuery.of(context).size.width < 1400 &&
                      MediaQuery.of(context).size.width >= 1024
                  ? 12
                  : 7,
              child: const Dashboard()),
        ],
      )),
    );
  }
}
