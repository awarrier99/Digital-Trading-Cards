import 'dart:convert';
import 'dart:isolate';

import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class NFCModel {
  void addUser(String username) async {
    // final receivePort = ReceivePort();
    // final map = {'port': receivePort.sendPort, 'username': username};
    // final isolate = await Isolate.spawn(notifier, map);
    // final sendPort = await receivePort.first;
    // NDEFMessage message = await NFC.readNDEF(once: true).first;
    // print(message.payload);
    Stream<NDEFMessage> stream = NFC.readNDEF();
    stream.listen((message) {
      print(message.payload);
      NDEFMessage newMessage = NDEFMessage.withRecords([
        NDEFRecord.type('application/json', json.encode({'username': username}))
      ]);
      message.tag.write(newMessage);
    });
  }
}

Future<void> notifier(Map<String, dynamic> map) async {
  try {
    final receivePort = ReceivePort();
    final sendPort = map['port'];
    final username = map['username'];

    final userMap = {'username': username};
    NDEFMessage message = NDEFMessage.withRecords(
        [NDEFRecord.type('application/json', json.encode(userMap))]);
    await NFC.writeNDEF(message, once: true).first;
  } catch (err, stacktrace) {
    print('An error occurred while trying to add a user with NFC');
    print(err);
    print(stacktrace);
  }
}
