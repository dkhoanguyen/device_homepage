import 'package:flutter/material.dart';
import 'package:device_homepage/constants.dart';

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
