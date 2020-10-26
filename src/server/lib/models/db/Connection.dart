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

  Future<void> save() async {
    try {
      String sql;
      final values = [sender.id, recipient.id, pending];
      if (id == null) {
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
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to save a connection:');
    }
  }

  static Future<List<Connection>> getByUser(User user) async {
    try {
      const sql = '''
        SELECT * FROM connections
        WHERE sender = ?
          OR recipient = ?
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
}
