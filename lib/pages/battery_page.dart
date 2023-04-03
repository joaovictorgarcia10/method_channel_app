import 'package:flutter/material.dart';
import 'package:method_channel_app/channel/channel_controller.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({Key? key}) : super(key: key);

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  final channel = ChannelController();

  // Get battery level.
  String batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    channel.getBatteryLevel().then((value) {
      batteryLevel = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Battery Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('The batery level is'),
            Text(batteryLevel),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getBatteryLevel,
        tooltip: 'Increment',
        child: const Icon(Icons.battery_charging_full_outlined),
      ),
    );
  }
}
