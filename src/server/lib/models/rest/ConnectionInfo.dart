import 'package:meta/meta.dart';

import '../../server.dart';

// represents a user's connection info
class ConnectionInfo extends Serializable {
  ConnectionInfo();

  ConnectionInfo.create(
      {@required this.user,
      @required this.connections,
      @required this.connectionCards});

  User user;
  List<Connection> connections;
  List<CardInfo> connectionCards;

  // serializes a class instance into a JSON response payload
  @override
  Map<String, dynamic> asMap() {
    return {
      'user': user.asMap(),
      'connections': connections.map((e) => e.asMap()).toList(),
      'connectionCards': connectionCards.map((e) => e.asMap()).toList()
    };
  }

  // serializes the JSON request payload into a class instance
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

  // get a list of a user's connections and their cards
  static Future<ConnectionInfo> getByUser(User user, {bool onlyPending, bool incoming}) async {
    List<Connection> connections;
    if (onlyPending) {
      connections = await Connection.getPending(user, incoming: incoming);
    } else {
      connections = await Connection.getByUser(user);
    }
    final connectionCards = await Connection.getConnectionCards(user, connections);
    return ConnectionInfo.create(
        user: user,
        connections: connections,
        connectionCards: connectionCards);
  }
}
