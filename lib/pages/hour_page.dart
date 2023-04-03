import 'package:flutter/material.dart';
import 'package:method_channel_app/channel/channel_controller.dart';

class HourPage extends StatefulWidget {
  const HourPage({Key? key}) : super(key: key);

  @override
  State<HourPage> createState() => _HourPageState();
}

class _HourPageState extends State<HourPage> {
  final controller = ChannelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hours Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Stream Method Channel Result:'),
            const SizedBox(height: 20.0),
            StreamBuilder(
              stream: controller.stream.receiveBroadcastStream(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const LinearProgressIndicator();
                }

                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headlineSmall,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
