import 'package:flutter_blue/flutter_blue.dart';

class BluetoothModel {
  void addUser(String username) async {
    final flutterBlue = FlutterBlue.instance;
    try {
      flutterBlue.startScan();
      flutterBlue.scanResults.listen((results) {
        for (final r in results) {
          print(r.device.name);
          print(r.device.type);
        }
      });
    } catch (err, stacktrace) {
      print('An error occurred while trying to add a user by Bluetooth:');
      print(err);
      print(stacktrace);
    } finally {
      flutterBlue.stopScan();
    }
  }
}
