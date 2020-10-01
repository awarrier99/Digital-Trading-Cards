import 'package:meta/meta.dart';
import 'package:dbcrypt/dbcrypt.dart';

import '../../server.dart';

class Event extends Serializable {
  Event();
  Event.create({
    @required this.eventName,
    @required this.startDate,
    @required this.endDate,
  });

  int id;
  User owner;
  String eventName;
  DateTime startDate;
  DateTime endDate;

  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'owner': owner,
      'eventName': eventName,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String()
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'] as int;
    if (owner == null && object['owner'] != null) {
      final userMap = object['owner'] as Map<String, dynamic>;
      if (stringToUserType(userMap['type'] as String) == UserType.student) {
        owner = Student()..readFromMap(userMap);
      } else {
        owner = Recruiter()..readFromMap(userMap);
      }
    }
    eventName = object['eventName'] as String;
    final startDateStr = object['startDate'] as String;
    startDate = startDateStr == null || startDateStr.isEmpty
        ? null
        : DateTime.parse(startDateStr);
    final endDateStr = object['endDate'] as String;
    endDate = endDateStr == null || endDateStr.isEmpty
        ? null
        : DateTime.parse(endDateStr);
  }

  Future<void> save() async {
    const sql = '''
      INSERT INTO event
      (owner, event_name, start_date, end_date)
      VALUES (?, ?, ?, ?)
    ''';
    final results = await ServerChannel.db
        .query(sql, [owner.id, eventName, startDate.toUtc(), endDate.toUtc()]);
    id = results.insertId;
  }

  static Future<Event> get(int id) async {
    try {
      const sql = '''
      SELECT * FROM event
      WHERE id = ?
    ''';
      final results = await ServerChannel.db.query(sql, [id]);
      if (results.isEmpty) {
        return null;
      }
      final result = (await ServerChannel.db.query(sql, [id])).first;
      return Event.create(
          eventName: result['event_name'] as String,
          startDate: result['start_date'] as DateTime,
          endDate: result['end_date'] as DateTime);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a user:');
      return null;
    }
  }
}
