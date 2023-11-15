import 'package:device_homepage/controllers/menu_app_controller.dart';
import 'package:device_homepage/responsive.dart';
import 'package:device_homepage/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_homepage/screens/main/components/side_menu.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              flex: 1,
              child: SideMenu(),
            ),
          const Expanded(flex: 5, child: Dashboard()),
        ],
      )),
    );
  }
}
