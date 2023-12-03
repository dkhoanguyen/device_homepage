import 'package:device_homepage/constants.dart';
import 'package:flutter/material.dart';

class ServiceCardWidget extends StatelessWidget {
  const ServiceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 120,
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: const Color.fromARGB(26, 0, 0, 0))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Logs",
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.refresh,
                              size: 17.0,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.download,
                              size: 17.0,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.clear,
                              size: 17.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
