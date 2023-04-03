import 'package:flutter/services.dart';

class ChannelController {
  ChannelController._();
  static final ChannelController _instance = ChannelController._();
  factory ChannelController() => _instance;

  static const hello = MethodChannel('unique.identifier.method/hello');
  static const battery = MethodChannel('unique.identifier.method/battery');

  Future<String> callHelloMethodChannel() async =>
      await hello.invokeMethod('getHelloWorld');

  Future<String> callHelloWithParamsMethodChannel(String? param) async {
    if (param == null || param.isEmpty) return '';
    return await hello.invokeMethod('getHelloWorld', {'user': param});
  }

  Future<String> getBatteryLevel() async {
    String batteryLevel;

    try {
      final int result = await battery.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    return batteryLevel;
  }

  EventChannel stream = const EventChannel('unique.identifier.method/stream');
}
