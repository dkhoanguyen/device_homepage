import 'package:device_homepage/responsive.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
        Text(nameTitle,
            style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: !Responsive.isMobile(context) ? 20 : 17)),
        const ActionSettings(),
      ],
    );
  }
}

class ActionSettings extends StatefulWidget {
  const ActionSettings({super.key});

  @override
  _ActionSettingsState createState() => _ActionSettingsState();
}

class _ActionSettingsState extends State<ActionSettings> {
  String dropdownValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 102, 185, 252),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border:
                  Border.all(color: const Color.fromARGB(255, 102, 185, 252))),
          child: const Row(
            children: [
              Icon(
                Icons.settings,
                size: 25,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Action", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          const DropdownMenuItem<Divider>(
              enabled: false,
              child: Divider(
                color: Colors.white,
              )),
          ...MenuItems.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value! as MenuItem);
        },
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color.fromARGB(255, 102, 185, 252),
          ),
          offset: const Offset(0, -5),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: [
            ...List<double>.filled(MenuItems.firstItems.length, 48),
            8,
            ...List<double>.filled(MenuItems.secondItems.length, 48),
          ],
          padding: const EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [update, reboot];
  static const List<MenuItem> secondItems = [shutdown];

  static const reboot = MenuItem(text: 'Reboot', icon: Icons.restart_alt);
  static const update = MenuItem(text: 'Update', icon: Icons.update);
  static const shutdown = MenuItem(text: 'Shutdown', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.reboot:
        break;
      case MenuItems.shutdown:
        break;
    }
  }
}
