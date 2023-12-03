import 'package:device_homepage/constants.dart';
import 'package:device_homepage/services/websocket_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tint/tint.dart';

class AdaptiveSwitch extends StatefulWidget {
  const AdaptiveSwitch({super.key});

  @override
  AdaptiveSwitchState createState() => AdaptiveSwitchState();
}

class AdaptiveSwitchState extends State<AdaptiveSwitch> {
  bool follow = false;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Transform.scale(
          scale: 0.75,
          child: Switch.adaptive(
            activeColor: Colors.blue,
            activeTrackColor: const Color.fromARGB(255, 171, 171, 171),
            inactiveTrackColor: const Color.fromARGB(255, 171, 171, 171),
            value: follow,
            onChanged: (follow) => setState(() {
              this.follow = follow;
              logContent.setToBottom(follow);
            }),
          )),
      const Text("Follow",
          style: TextStyle(color: Colors.black, fontSize: 12.0))
    ]);
  }
}

class LogsViewer extends ConsumerWidget {
  LogsViewer({super.key});

  bool follow = false;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      height: 725 - defaultPadding,
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
                padding: EdgeInsets.all(defaultPadding),
                child: Text(
                  "Logs",
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Row(
                  children: [
                    const AdaptiveSwitch(),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        logContent.setClear(false);
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
                        ref.invalidate(logsServiceProvider);
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
          const Expanded(child: logWindow),
        ],
      ),
    );
  }
}

const logWindow = LogsWindow();
final logContent = LogsContent();

class LogsWindow extends StatelessWidget {
  const LogsWindow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: logContent,
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

  final List<String> _logs = List<String>.empty(growable: true);
  bool _toBottom = false;

  void setToBottom(bool toBottom) {
    _toBottom = toBottom;
  }

  void scrollToBottom() {
    if (_toBottom) {
      var scrollPosition = _controller.position;
      _controller.jumpTo(scrollPosition.maxScrollExtent);
    }
  }

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context, ref) {
    return ref.watch(logsProvider).when(data: (logsProvider) {
      _logs.add(logsProvider);
      return ListView.builder(
        shrinkWrap: true,
        controller: _controller,
        itemCount: _clear ? 0 : _logs.length,
        itemBuilder: (context, index) {
          return _clear
              ? const ListTile(
                  title: SelectableText(""),
                )
              : ListTile(
                  minVerticalPadding: 0.0,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(vertical: -4),
                  title: _LogDetails(_logs[index].strip(), "watchtower"),
                );
        },
      );
    }, error: (logsProvider, err) {
      return const SelectableText("Error");
    }, loading: () {
      return const Text("Loading logs...");
    });
  }
}

class _LogDetails extends StatelessWidget {
  String? timestamp;
  String? logType;
  String? containerName;
  String? content;
  String? remainder;

  _LogDetails(String logEntry, String containerName) {
    parseLogEntry(logEntry, containerName);
  }

  void parseLogEntry(String logEntry, String containerName) {
    // Split the log entry by whitespace
    List<String> logParts = logEntry.split(" ");

    // Extract timestamp and log type
    timestamp = logParts[0];
    logType =
        logParts[2].length >= 4 ? logParts[2].substring(0, 4) : logParts[2];
    remainder = logParts[2].replaceAll(logType!, "");
    content = logEntry.replaceAll(logParts[0], "");
    content = content!.replaceAll(logParts[2], "");
  }

  Color logTypeColor(String type) {
    if (type.contains("INFO")) {
      return Colors.green;
    }
    if (type.contains("WARN")) {
      return Colors.yellow;
    }
    if (type.contains("ERRO")) {
      return Colors.red;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "$timestamp ",
          style: const TextStyle(
              fontFamily: 'Ubuntu Mono', fontSize: 13, color: Colors.white)),
      TextSpan(
          text: logType! + remainder!,
          style: TextStyle(
              fontFamily: 'Ubuntu Mono',
              fontSize: 13,
              color: logTypeColor(logType!))),
      TextSpan(
          text: content,
          style: const TextStyle(
              fontStyle: FontStyle.normal,
              fontFamily: 'Ubuntu Mono',
              fontSize: 13,
              color: Colors.white)),
    ]));
  }
}
