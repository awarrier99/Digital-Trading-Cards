import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class NFCModel {
  void addUser(String username) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(listener, receivePort.sendPort);
    final sendPort = await receivePort.first;
    final userMap = {'username': username};
    NDEFMessage message = NDEFMessage.withRecords(
        [NDEFRecord.type('application/json', json.encode(userMap))]);
    await NFC.writeNDEF(message, once: true).first;
    isolate.kill();
  }
}

Future<void> listener(SendPort sendPort) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    NDEFMessage message = await NFC.readNDEF(once: true).first;
    print(message.payload);
  } catch (err) {
    print('An error occurred while trying to add a user with NFC');
  }
}
