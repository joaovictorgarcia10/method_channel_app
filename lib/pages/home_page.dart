import 'package:flutter/material.dart';
import 'package:method_channel_app/pages/battery_page.dart';
import 'package:method_channel_app/pages/hello_page.dart';
import 'package:method_channel_app/pages/hour_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigateTo(Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Method Channel App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Hello Channel"),
              onPressed: () => navigateTo(const HelloPage()),
            ),
            ElevatedButton(
              child: const Text("Battery Channel"),
              onPressed: () => navigateTo(const BatteryPage()),
            ),
            ElevatedButton(
              child: const Text("Hour Channel"),
              onPressed: () => navigateTo(const HourPage()),
            ),
          ],
        ),
      ),
    );
  }
}
