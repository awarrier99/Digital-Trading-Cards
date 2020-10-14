import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:ui/models/User.dart';

class EventInfo {
  int id;
  User owner;
  String eventName;
  DateTime startDate;
  DateTime endDate;

  EventInfo(
      {this.id, this.owner, this.eventName, this.startDate, this.endDate});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner': owner.toJson(),
      'eventName': eventName,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String()
    };
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    id = json['id'];
    owner = User()..fromJson(json['owner']);
    eventName = json['eventName'];
    startDate =
        json['startDate'] == null ? null : DateTime.parse(json['startDate']);
    endDate = json['endDate'] == null ? null : DateTime.parse(json['endDate']);
  }
}

class EventInfoModel {
  final EventInfo _eventInfo = EventInfo();
  EventInfo get eventInfo => _eventInfo;

  Future<EventInfo> fetchEventInfo(int id, String token) async {
    final responce = await get('http://10.0.2.2:8888/api/events/$id', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final body = json.decode(responce.body);
    print(body);
    if (responce.statusCode == 200) {
      return EventInfo()..fromJson(body);
    } else {
      return null;
    }
  }
}
