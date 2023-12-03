import 'package:device_homepage/constants.dart';
import 'package:device_homepage/screens/dashboard/service/controller_dashboard_screen.dart';
import 'package:device_homepage/screens/main_screen.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      backgroundColor: const Color.fromARGB(255, 63, 63, 63),
      child: ListView(
        children: [
          MediaQuery.of(context).size.width < 1400 &&
                  MediaQuery.of(context).size.width >= 1024
              ? const SizedBox(height: 50)
              : DrawerHeader(child: Container()),
          DrawerListTile(
            title: "Dashboard",
            icon: const Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
            },
          ),
          DrawerListTile(
            title: "Instruction",
            icon: const Icon(Icons.description_rounded, color: Colors.white),
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondRoute()),
              );
            },
          ),
          DrawerListTile(
            title: "Settings",
            icon: const Icon(Icons.settings, color: Colors.white),
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String title;
  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        onTap: press,
        horizontalTitleGap: defaultPadding,
        title: MediaQuery.of(context).size.width < 1400 &&
                MediaQuery.of(context).size.width >= 1024
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                ],
              )
            : Row(
                children: [
                  icon,
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
      ),
    );
  }
}
