import 'package:meta/meta.dart';

import '../../server.dart';
import 'User.dart';

// represents a connection between two users
class Connection extends Serializable {
  Connection();

  Connection.create(
      {@required this.sender, @required this.recipient, this.pending = true});

  int id;
  User sender;
  User recipient;
  bool pending;

  // serializes a class instance into a JSON response payload
  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'sender': sender.asMap(),
      'recipient': recipient.asMap(),
      'pending': pending
    };
  }

  // serializes the JSON request payload into a class instance
  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'] as int;
    final senderMap = object['sender'] as Map<String, dynamic>;
    final recipientMap = object['recipient'] as Map<String, dynamic>;
    sender = User.fromMap(senderMap);
    recipient = User.fromMap(recipientMap);
    pending = object['pending'] as bool;
  }

  // save or update a class instance in the database
  Future<bool> save() async {
    String sql;
    final values = [sender.id, recipient.id, pending];
    if (id == null) { // if the id isn't set, create a new row
      const checkSql = '''
        SELECT * FROM connections
        WHERE sender = ? AND recipient = ?
          OR recipient = ? AND sender = ?
      ''';
      final checkResults = await ServerChannel.db
          .query(checkSql, [sender.id, recipient.id, sender.id, recipient.id]);
      if (checkResults.isNotEmpty) { // check whether the connection tuple already exists
        return false;
      }

      sql = '''
        INSERT INTO connections
        (sender, recipient, pending)
        VALUES (?, ?, ?)
      ''';
    } else { // if the id is set, update the properties
      sql = '''
        UPDATE connections
        SET pending = ?
        WHERE id = ?
      ''';
      values.clear();
      values.add(pending);
      values.add(id);
    }
    final results = await ServerChannel.db.query(sql, values);
    id ??= results.insertId;
    return true;
  }

  // delete a class instance from the database
  Future<void> delete() async {
    try {
      if (id == null) {
        print('Unsaved connection cannot be deleted');
        return;
      }

      const sql = '''
        DELETE FROM connections
        WHERE id = ?
      ''';

      await ServerChannel.db.query(sql, [id]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to delete a connection:');
    }
  }

  // get a connection by id
  static Future<Connection> get(int id) async {
    const sql = '''
      SELECT * FROM connections
      WHERE id = ?
    ''';

    final results = await ServerChannel.db.query(sql, [id]);
    if (results.isEmpty) {
      return null;
    }

    final connectionRow = results.first;
    return Connection.create(
        sender: await User.get(connectionRow['sender'] as int),
        recipient: await User.get(connectionRow['recipient'] as int),
        pending: (connectionRow['pending'] as int) == 1)
      ..id = id;
  }

  // get a connection by a user
  static Future<List<Connection>> getByUser(User user) async {
    try {
      const sql = '''
        SELECT * FROM connections
        WHERE (sender = ?
          OR recipient = ?)
          AND pending = 0
      ''';
      final results = await ServerChannel.db.query(sql, [user.id, user.id]);

      final resultFutures = results.map((e) async => Connection.create(
          sender: await User.get(e['sender'] as int),
          recipient: await User.get(e['recipient'] as int),
          pending: (e['pending'] as int) == 1)
        ..id = e['id'] as int);
      return Future.wait(resultFutures);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message:
              'An error occurred while trying to get user connection info:');
      return [];
    }
  }

  // get the cards of the users the current user is connected with
  static Future<List<CardInfo>> getConnectionCards(
      User user, List<Connection> connections) async {
    final futures = connections.map((e) {
      User u = e.recipient;
      if (u.id == user.id) {
        u = e.sender;
      }
      return CardInfo.get(u);
    });
    return Future.wait(futures);
  }

  // get all pending connection requests
  static Future<List<Connection>> getPending(User user, {bool incoming}) async {
    String key = 'recipient';
    if (!incoming) { // specify whether the current user is the sender or recipient
      key = 'sender';
    }
    final sql = '''
      SELECT * FROM connections
      WHERE $key = ?
        AND pending = 1
    ''';
    final results = await ServerChannel.db.query(sql, [user.id]);

    List<Future<Connection>> resultFutures;
    if (incoming) {
      resultFutures = results
          .map((e) async => Connection.create(
              sender: await User.get(e['sender'] as int),
              recipient: user,
              pending: (e['pending'] as int) == 1)
            ..id = e['id'] as int)
          .toList();
    } else {
      resultFutures = results
          .map((e) async => Connection.create(
              sender: user,
              recipient: await User.get(e['recipient'] as int),
              pending: (e['pending'] as int) == 1)
            ..id = e['id'] as int)
          .toList();
    }
    return Future.wait(resultFutures);
  }
}
