// This file holds relevant classes for connecting to the back end for an event
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ui/models/User.dart';

class EventInfo {
  int id;
  User owner;
  String company;
  String eventDescription;
  String eventName;
  DateTime startDate;
  DateTime endDate;

  // TODO: Add location

// EventInfo is a model that will hold all information relevent to a users trading card
  EventInfo({
    this.id,
    this.owner,
    this.eventName,
    this.company,
    this.eventDescription,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner': owner.toJson(),
      'company': company,
      'eventDescription': eventDescription,
      'eventName': eventName,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String()
    };
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    id = json['id'];
    owner = User()..fromJson(json['owner']);
    eventName = json['eventName'];
    eventDescription = json['eventDescription'];
    company = json['company'];
    startDate =
        json['startDate'] == null ? null : DateTime.parse(json['startDate']);
    endDate = json['endDate'] == null ? null : DateTime.parse(json['endDate']);
  }

  void fromEvent(EventInfo eventInfo) {
    id = eventInfo.id;
    owner = eventInfo.owner;
    company = eventInfo.company;
    eventDescription = eventInfo.eventDescription;
    eventName = eventInfo.eventName;
    startDate = eventInfo.startDate;
    endDate = eventInfo.endDate;
  }
}

// the event Info Model is used for making api calls regarding cards
class EventInfoModel {
  final EventInfo _eventInfo = EventInfo();
  EventInfo get eventInfo => _eventInfo;

  bool isEditing = false;

  // sends a post call to the API to create an event
  // token is a string that is used to validate that the api call is coming from our application
  Future<bool> createEvent(String token) async {
    try {
      print('hello3');
      print(_eventInfo.toJson());
      final res = await post('http://10.0.2.2:8888/api/events',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(_eventInfo.toJson()));
      final body = json.decode(res.body);
      final success = body['success'];
      if (!success) return false;
      // _eventInfo.id = body['id'];
      return true;
    } catch (err) {
      return false;
    }
  }

  // Sends a put call to the API to update an event
  // id: the id of the event that will be updated
  // token: string that is used to validate that the api call is coming from our application
  Future<bool> update(int id, String token) async {
    try {
      final res = await put('http://10.0.2.2:8888/api/events/$id',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(_eventInfo.toJson()));
      final body = json.decode(res.body);
      final success = body['success'];
      if (!success) return false;
      _eventInfo.id = body['id'];
      return true;
    } catch (err) {
      return false;
    }
  }

  // makes a call to the API to get the information of a specific event
  // id: the id of the event that you want to get the information of
  // token: string that is used to validate that the api call is coming from our application
  Future<EventInfo> fetchEventInfo(int id, String token) async {
    final response = await get('http://10.0.2.2:8888/api/events/$id', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final body = json.decode(response.body);
    if (response.statusCode == 200) {
      return EventInfo()..fromJson(body);
    } else {
      return null;
    }
  }

  // makes a call to the API to get all upcoming events that a user is rsvped for
  // userId: the id of the user that you want to get the upcoming events of
  // token: string that is used to validate that the api call is coming from our application
  Future<List<EventInfo>> fetchUpcomingEvents(int userId, String token) async {
    final response =
        await get('http://10.0.2.2:8888/api/allEvents/$userId', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final body = json.decode(response.body);
    if (response.statusCode == 200) {
      return new List<EventInfo>.from(
          body.map((element) => EventInfo()..fromJson(element)).toList());
    } else {
      return null;
    }
  }

  // makes a call to the API to get all attendes for an event
  // eventId: the id of the event you want to get the attendees for
  // token: string that is used to validate that the api call is coming from our application
  Future<List<User>> fetchAttendees(int eventId, String token) async {
    final response = await get(
        'http://10.0.2.2:8888/api/events/attendees/$eventId',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    final body = json.decode(response.body);
    if (response.statusCode == 200) {
      return new List<User>.from(
          body.map((element) => User()..fromJson(element)).toList());
    } else {
      return null;
    }
  }

  // registers the user for the event
  // token: string that is used to validate that the api call is coming from our application
  Future<bool> registerForEvent(String token) async {
    try {
      final res = await post('http://10.0.2.2:8888/api/events/attendees',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: json.encode(_eventInfo.toJson()));

      final body = json.decode(res.body);
      final success = body['success'];
      if (!success) return false;
      return true;
    } catch (err) {
      return false;
    }
  }
}
