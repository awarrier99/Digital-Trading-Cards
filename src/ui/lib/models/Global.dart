import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/ConnectionInfo.dart';
import 'package:ui/models/EventInfo.dart';
import 'package:ui/models/User.dart';

class GlobalModel {
  final UserModel userModel = UserModel();
  final CardInfoModel cardInfoModel = CardInfoModel();
  final ConnectionInfoModel connectionInfoModel = ConnectionInfoModel();
  final EventInfoModel eventInfoModel = EventInfoModel();

  Future<List<dynamic>> getSuggestions(String endpoint, String pattern,
      String key, Function classBuilder) async {
    pattern = pattern.replaceAll(' ', '%20');
    final res = await get('http://10.0.2.2:8888$endpoint/$pattern', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userModel.token}',
    });
    final body = json.decode(res.body);
    final success = body['success'];
    if (!success) return [];

    final results = body[key] as List;
    return results.map((e) => classBuilder()..fromJson(e)).toList();
  }

  Future<void> onAdd(
      String endpoint, dynamic model, BuildContext context) async {
    await post('http://10.0.2.2:8888$endpoint',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userModel.token}',
        },
        body: json.encode(model.toJson()));
    Navigator.of(context).pop();
  }

  void logout() {
    userModel.empty();
    cardInfoModel.empty();
    connectionInfoModel.empty();
  }
}
