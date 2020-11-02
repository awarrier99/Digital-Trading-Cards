import 'package:nfc_manager/nfc_manager.dart';

class NFCModel {
  void addUser(String username) async {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      print(tag.data);
      NfcManager.instance.stopSession();
    });
  }
}
