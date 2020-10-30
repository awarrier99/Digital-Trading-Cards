import 'package:meta/meta.dart';

import '../../server.dart';
import 'User.dart';

class Connection extends Serializable {
  Connection();

  Connection.create(
      {@required this.sender, @required this.recipient, this.pending = true});

  int id;
  User sender;
  User recipient;
  bool pending;

  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'sender': sender.asMap(),
      'recipient': recipient.asMap(),
      'pending': pending
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'] as int;
    final senderMap = object['sender'] as Map<String, dynamic>;
    final recipientMap = object['recipient'] as Map<String, dynamic>;
    sender = User.fromMap(senderMap);
    recipient = User.fromMap(recipientMap);
    pending = object['pending'] as bool;
  }

  Future<bool> save() async {
    String sql;
    final values = [sender.id, recipient.id, pending];
    if (id == null) {
      const checkSql = '''
        SELECT * FROM connections
        WHERE sender = ? AND recipient = ?
          OR recipient = ? AND sender = ?
      ''';
      final checkResults = await ServerChannel.db
          .query(checkSql, [sender.id, recipient.id, sender.id, recipient.id]);
      if (checkResults.isNotEmpty) {
        return false;
      }

      sql = '''
        INSERT INTO connections
        (sender, recipient, pending)
        VALUES (?, ?, ?)
      ''';
    } else {
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

  static Future<List<Connection>> getPending(User user, {bool incoming}) async {
    String key = 'recipient';
    if (!incoming) {
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
