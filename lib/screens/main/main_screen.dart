import 'package:device_homepage/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_homepage/screens/main/components/side_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SideMenu(),
          ),
          Expanded(flex: 5, child: Dashboard()),
        ],
      )),
    );
  }
}
