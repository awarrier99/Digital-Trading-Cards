import 'package:meta/meta.dart';

import '../../server.dart';

class ConnectionInfo extends Serializable {
  ConnectionInfo(
      {@required this.user,
      @required this.connections,
      @required this.connectedUsers});

  User user;
  List<Connection> connections;
  List<CardInfo> connectedUsers;

  @override
  Map<String, dynamic> asMap() {
    return {
      "user": user.asMap(),
      "connections": connections.map((e) => e.asMap()).toList(),
      "connectedUsers": connectedUsers.map((e) => e.asMap()).toList(),
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    final userMap = object['user'] as Map<String, dynamic>;
    final connectionList = object['connections'] as List;
    final connectedUsersList = object['connectedUsers'] as List;

    connections = connectionList
        .map((e) => Connection()..readFromMap(e as Map<String, dynamic>))
        .toList();

    connectedUsers = connectedUsersList
        .map((e) => CardInfo()..readFromMap(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> create(ConnectionInfo connectionInfo) async {
    final List<Future> futures = [];
    await connectionInfo.user.save();
    futures.add(Future.forEach(
        connectionInfo.connections,
        (Connection e) =>
            Connection.create(user1: e.user1, user2: e.user2)..save()));
    futures.add(Future.forEach(connectionInfo.connectedUsers,
        (CardInfo e) async => CardInfo.getById(e.user.id)));
    await Future.wait(futures);
  }

  static Future<ConnectionInfo> get(User user) async {
    return ConnectionInfo(
        user: user,
        connections: await Connection.getByUser(user),
        connectedUsers: await Connection.getOtherUsers(user));
  }
}
