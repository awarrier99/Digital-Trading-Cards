// This file holds relevant classes for connecting to the back end for the users connections
import 'dart:convert';
import 'package:http/http.dart';

class Message {
  int id;
  int senderId;
  int receiverId;
  String text;
  DateTime timestamp;

  Message({
    this.id,
    this.senderId,
    this.receiverId,
    this.text,
    this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timestamp': timestamp?.toIso8601String()
    };
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    id = json['id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    text = json['text'];
    timestamp = DateTime.parse(json['timestamp']);
  }
}

class MessageModel {
  final Message _createMessageModel = Message();
  Message get createConnectionInfo => _createMessageModel;

  Future<List<Message>> fetchMessages(
      int senderId, int receiverId, String token) async {
    final response = await get(
        'http://34.75.44.166:8888/api/messaging/$senderId/$receiverId',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    final body = json.decode(response.body);
    if (response.statusCode == 200) {
      return new List<Message>.from(
          body.map((element) => Message()..fromJson(element)).toList());
    } else {
      return null;
    }
  }

  Future<bool> sendMessage(int senderId, int receiverId, DateTime timestamp,
      String text, String token) async {
    try {
      print(text);
      final res = await post('http://34.75.44.166:8888/api/messaging',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(Message(
                  senderId: senderId,
                  receiverId: receiverId,
                  timestamp: timestamp,
                  text: text)
              .toJson()));
      final body = json.decode(res.body);
      final success = body['success'];
      if (!success) return false;
      // _eventInfo.id = body['id'];
      return true;
    } catch (err) {
      return false;
    }
  }
}
