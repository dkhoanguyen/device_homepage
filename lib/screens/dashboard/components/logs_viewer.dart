import 'package:device_homepage/constants.dart';
import 'package:device_homepage/services/api_client.dart';
import 'package:device_homepage/services/websocket_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:tint/tint.dart';

class LogsViewer extends ConsumerWidget {
  const LogsViewer({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      height: 365 - defaultPadding,
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Text(
                  "Logs",
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        logContent.setClear(false);
                        ref.refresh(containerLogsProvider);
                        Future.delayed(const Duration(milliseconds: 500), () {
                          logWindow.setToBottom(true);
                        });
                      },
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
                      onPressed: () {
                        logContent.setClear(true);
                        ref.invalidate(containerLogsProvider);
                      },
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
          Expanded(child: logWindow),
        ],
      ),
    );
  }
}

final logWindow = LogsWindow();
final logContent = LogsContent();

class LogsWindow extends StatelessWidget {
  LogsWindow({
    super.key,
  });

  void setToBottom(bool toBottom) {
    var scrollPosition = _controller.position;

    _controller.jumpTo(scrollPosition.maxScrollExtent);
  }

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: _controller,
        child: Column(
          children: [logContent],
        ),
      ),
    );
  }
}

class LogsContent extends ConsumerWidget {
  LogsContent({
    super.key,
  });

  bool _clear = true;

  void setClear(bool clear) {
    _clear = clear;
  }

  @override
  Widget build(BuildContext context, ref) {
    return ref.watch(containerLogsProvider).when(data: (containerLogsProvider) {
      return _clear
          ? const Text("")
          : SelectableText(
              containerLogsProvider.strip(),
              style: const TextStyle(fontFamily: "monospace", fontSize: 12.0),
            );
    }, error: (hardwareStatusProvider, err) {
      return const SelectableText("Error");
    }, loading: () {
      return const Text("Loading logs...");
    });
  }
}
