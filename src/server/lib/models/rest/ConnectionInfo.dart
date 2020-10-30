import 'package:meta/meta.dart';

import '../../server.dart';

class ConnectionInfo extends Serializable {
  ConnectionInfo();

  ConnectionInfo.create(
      {@required this.user,
      @required this.connections,
      @required this.connectionCards});

  User user;
  List<Connection> connections;
  List<CardInfo> connectionCards;

  @override
  Map<String, dynamic> asMap() {
    return {
      'user': user.asMap(),
      'connections': connections.map((e) => e.asMap()).toList(),
      'connectionCards': connectionCards.map((e) => e.asMap()).toList()
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    user = User.fromMap(object['user'] as Map<String, dynamic>);
    final connectionsList = object['connections'] as List;
    connections = connectionsList
        .map((e) => Connection()..readFromMap(e as Map<String, dynamic>))
        .toList();
    final connectionCardsList = object['connectionCards'] as List;
    connectionCards = connectionCardsList
        .map((e) => CardInfo()..readFromMap(e as Map<String, dynamic>))
        .toList();
  }

  static Future<ConnectionInfo> getByUser(User user, {bool getCards}) async {
    final connections = await Connection.getByUser(user);
    List<CardInfo> connectionCards = [];
    if (getCards) {
      connectionCards = await Connection.getConnectionCards(user, connections);
    }
    return ConnectionInfo.create(
        user: user,
        connections: connections,
        connectionCards: connectionCards);
  }
}
