import 'package:flutter/material.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/ConnectionInfo.dart';
import 'package:ui/models/User.dart';

class GlobalModel {
  final UserModel userModel = UserModel();
  final CardInfoModel cardInfoModel = CardInfoModel();
  final ConnectionInfoModel connectionInfoModel = ConnectionInfoModel();
  final GlobalKey<NavigatorState> navigatorKey;

  GlobalModel(this.navigatorKey);

  void logout() {
    userModel.empty();
    cardInfoModel.empty();
    connectionInfoModel.empty();
  }
}
