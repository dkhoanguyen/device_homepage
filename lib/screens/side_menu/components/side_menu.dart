import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(),
          ),
          DrawerListTile(
            title: "Dashboard",
            icon: const Icon(Icons.dashboard),
            press: () {},
          ),
          DrawerListTile(
            title: "Configuration",
            icon: const Icon(Icons.handyman),
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            icon: const Icon(Icons.settings),
            press: () {},
          ),
          DrawerListTile(
            title: "Instructions",
            icon: const Icon(Icons.description_rounded),
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
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
