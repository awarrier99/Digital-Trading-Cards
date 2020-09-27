import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:convert';
import 'package:ui/models/User.dart';
import 'package:ui/models/CardInfo.dart';

class Connection {
  User user1;
  User user2;

  Map<String, dynamic> toJson() {
    return {
      'user1': user1.toJson(),
      'user2': user2.toJson()
    };
  }


  Connection.fromJson(Map<String, dynamic> json) {
    user1 = User()..fromJson(json['user1']);
    user2 = User()..fromJson(json['user2']);
  }

}

class ConnectionInfo {
  User user = User();
  List<Connection> connections = [];
  List<CardInfo> connectedUsers = [];

  ConnectionInfo();

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'connections': connections.map((e) => e.toJson()).toList(),
      'connectedUsers': connectedUsers.map((e) => e.toJson()).toList(),
    };
  }

  ConnectionInfo.fromJson(Map<String, dynamic> json) {
    user = User()..fromJson(json['user']);
    for(connection in json['connections']) {
      connections.add(Connection..fromJson(connection))
    }
    //

    connectedUsers = json['connectedUsers'];
  }
}

class ConnectionInfoModel { // TODO strip whitespace from inputs
  final ConnectionInfo _createConnectionInfo = ConnectionInfo();
  ConnectionInfo get createConnectionInfo => _createConnectionInfo;

  Future<bool> createConnection() async {
    try {
      final res = await post('http://10.0.2.2:8888/api/connections', headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }, body: json.encode(_createConnectionInfo.toJson()));
      final body = json.decode(res.body);
      return body['success'] as bool;
    } catch (err) {
      print('An error occurred while trying to create a connection:');
      print(err);
      return false;
    }
  }
}

// TODO: where should this fetch method go?
Future<ConnectionInfo> fetchConnectionInfo(int id) async {
  final response = await get("http://10.0.2.2:8888/api/connections/$id");
  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return ConnectionInfo.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load connection info');
  }
}
