import 'package:flutter/material.dart';

class CpuUsageGraph extends StatefulWidget {
  const CpuUsageGraph({super.key});

  @override
  _CpuUsageGraphState createState() => _CpuUsageGraphState();
}

class _CpuUsageGraphState extends State<CpuUsageGraph> {
  double cpuUsage = 0.6;

  @override
  void initState() {
    super.initState();
    fetchData();

    // // Schedule periodic updates every minute
    // Timer.periodic(Duration(minutes: 1), (timer) {
    //   fetchData();
    // });
  }

  Future<void> fetchData() async {
    // final response = await http.get(Uri.parse('YOUR_BACKEND_API_ENDPOINT'));

    // if (response.statusCode == 200) {
    //   final List<dynamic> responseData = json.decode(response.body);
    //   final double latestCpuUsage =
    //       responseData.isNotEmpty ? responseData.last['cpuUsage'] : 0.0;
    //   setState(() {
    //     cpuUsage = latestCpuUsage;
    //   });
    // } else {
    //   // Handle error
    //   print('Failed to load CPU usage data');
    // }
  }

  @override
  Widget build(BuildContext context) {
    Color progressBarColor = cpuUsage > 0.5
        ? const Color.fromRGBO(244, 67, 54, 1)
        : const Color.fromRGBO(76, 175, 80, 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'CPU Usage',
              style: TextStyle(fontSize: 12.0),
            ),
            Text(
              '${(cpuUsage * 100).toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        LinearProgressIndicator(
          color: const Color.fromRGBO(76, 175, 80, 1),
          value: cpuUsage, // Set the progress value
          minHeight: 12.0,
          borderRadius: BorderRadius.circular(3),
          valueColor: AlwaysStoppedAnimation<Color>(progressBarColor),
        ),
      ],
    );
  }
}
