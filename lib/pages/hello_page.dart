import 'package:flutter/material.dart';
import 'package:method_channel_app/channel/channel_controller.dart';

class HelloPage extends StatefulWidget {
  const HelloPage({Key? key}) : super(key: key);

  @override
  HelloPageState createState() => HelloPageState();
}

class HelloPageState extends State<HelloPage> {
  final channelController = ChannelController();

  String result = '';
  String? nameRequest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Platform Channel Guide")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  onChanged: (val) => nameRequest = val,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
              ),
              const Text('Method Channel Result:'),
              const SizedBox(height: 20.0),
              Text(
                result,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'exemplo1',
            onPressed: () async {
              result = await channelController.callHelloMethodChannel();
              setState(() {});
            },
            tooltip: 'Call Method Channel',
            child: const Text('1'),
          ),
          const SizedBox(width: 20.0),
          FloatingActionButton(
            heroTag: 'exemplo2',
            onPressed: () async {
              result = await channelController
                  .callHelloWithParamsMethodChannel(nameRequest);
              setState(() {});
            },
            tooltip: 'Call Method Channel with param',
            child: const Text('2'),
          ),
        ],
      ),
    );
  }
}
