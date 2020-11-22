import 'package:meta/meta.dart';

import '../../server.dart';

class Message extends Serializable {
  Message();
  Message.create(
      {@required this.senderId,
      @required this.receiverId,
      @required this.text,
      @required this.timestamp});

  int id;
  int senderId;
  int receiverId;
  String text;
  DateTime timestamp;

  // serializes a class instance into a JSON response payload
  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timestamp': timestamp.toIso8601String()
    };
  }

  // serializes the JSON request payload into a class instance
  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'] as int;
    senderId = object['senderId'] as int;
    receiverId = object['receiverId'] as int;
    text = object['text'] as String;
    timestamp = DateTime.parse(object['timestamp'] as String);
  }

  // save a class instance in the database
  Future<void> save() async {
    const sql = '''
      INSERT INTO messages
      (senderId, receiverId, text, timestamp)
      VALUES (?, ?, ?, ?)
    ''';
    final results = await ServerChannel.db
        .query(sql, [senderId, receiverId, text, timestamp.toUtc()]);
    id = results.insertId;
  }

  static Future<Message> get(int id) async {
    const sql = '''
      SELECT * FROM messages
      WHERE id = ?
    ''';

    final results = await ServerChannel.db.query(sql, [id]);
    if (results.isEmpty) {
      return null;
    }

    final messageRow = results.first;
    return Message.create(
        receiverId: messageRow['receiverId'] as int,
        senderId: messageRow['senderId'] as int,
        text: messageRow['text'] as String,
        timestamp: messageRow['timestamp'] as DateTime)
      ..id = id;
  }

  // get all upcoming events for a user
  static Future<List<Message>> getMessages(int senderId, int receiverId) async {
    try {
      const sql = '''
          SELECT * FROM messages
          WHERE senderId = ? AND receiverId = ? 
          ORDER BY timestamp ASC
        ''';
      final results = await ServerChannel.db.query(sql, [senderId, receiverId]);
      print(results);

      final resultsList =
          results.map((e) async => Message.get(e['id'] as int)).toList();
      return Future.wait(resultsList);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get messages:');
      return [];
    }
  }
}
