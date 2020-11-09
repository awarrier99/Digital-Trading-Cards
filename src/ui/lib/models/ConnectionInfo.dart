import 'dart:convert';

import 'package:http/http.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/User.dart';

class Connection {
  int id;
  User sender;
  User recipient;
  bool pending;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender.toJson(),
      'recipient': recipient.toJson(),
      'pending': pending
    };
  }

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = User()..fromJson(json['sender']);
    recipient = User()..fromJson(json['recipient']);
    pending = json['pending'];
  }
}

class ConnectionInfo {
  User user = User();
  List<Connection> connections = [];
  List<CardInfo> connectionCards = [];

  ConnectionInfo({this.user, this.connections, this.connectionCards});

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'connections': connections.map((e) => e.toJson())?.toList(),
      'connectedUsers': connectionCards.map((e) => e.toJson())?.toList(),
    };
  }

  void fromJson(Map<String, dynamic> json) {
    user = User()..fromJson(json['user']);
    connections = (json['connections'] as List)
        ?.map((element) => Connection()..fromJson(element))
        ?.toList();
    connectionCards = (json['connectionCards'] as List)
        ?.map((element) => CardInfo()..fromJson(element))
        ?.toList();
  }
}

class ConnectionInfoModel {
  // TODO strip whitespace from inputs
  final ConnectionInfo _createConnectionInfo = ConnectionInfo();
  ConnectionInfo get createConnectionInfo => _createConnectionInfo;

  Future<bool> createConnection(User user, String token) async {
    try {
      final res = await post('http://10.0.2.2:8888/api/connections',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(user.toJson()));
      final body = json.decode(res.body);
      return body['success'];
    } catch (err) {
      print('An error occurred while trying to create a connection:');
      print(err);
      return false;
    }
  }

  Future<bool> acceptConnection(Connection connection, String token) async {
    try {
      final res =
          await put('http://10.0.2.2:8888/api/connections/${connection.id}',
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token'
              },
              body: json.encode(connection.toJson()));
      final body = json.decode(res.body);
      return body['success'];
    } catch (err) {
      print('An error occurred while trying to accept a connection:');
      print(err);
      return false;
    }
  }

  Future<bool> rejectConnection(int id, String token) async {
    try {
      final res =
          await delete('http://10.0.2.2:8888/api/connections/$id', headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      final body = json.decode(res.body);
      return body['success'];
    } catch (err) {
      print('An error occurred while trying to reject a connection:');
      print(err);
      return false;
    }
  }

  Future<ConnectionInfo> fetchConnectionInfo(int id, String token,
      {bool onlyPending = false, bool incoming = true}) async {
    final response = await get(
        'http://10.0.2.2:8888/api/connections/$id?onlyPending=$onlyPending&incoming=$incoming',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    final body = json.decode(response.body);
    if (response.statusCode == 200) {
      return ConnectionInfo()..fromJson(body);
    } else {
      throw Exception('Failed to load connection info');
    }
  }

  void empty() {
    _createConnectionInfo.fromJson({});
  }
}
