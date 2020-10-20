import 'package:meta/meta.dart';
import 'package:dbcrypt/dbcrypt.dart';

import '../../server.dart';

class Event extends Serializable {
  Event();
  Event.create({
    @required this.owner,
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
      'owner': owner.asMap(),
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

  Future<void> addAttendee() async {
    const sql = ''' 
      INSERT INTO attendees 
      (event, user)
      VALUES (?,?)
    ''';
    final results = await ServerChannel.db.query(sql, [id, owner.id]);
    id = results.insertId;
  }

  static Future<List<User>> getAttendees(int eventId) async {
    try {
      const sql = '''
        SELECT * FROM attendees 
        JOIN users ON attendees.user=users.id
        WHERE attendees.event=?
      ''';
      final results = await ServerChannel.db.query(sql, [eventId]);
      print(results);
      final resultFutures = results.map((e) async => {
        if (stringToUserType(e['type'] as String) == UserType.student) {
        Student.create(
            firstName: e['first_name'] as String,
            lastName: e['last_name'] as String,
            username: e['user_name'] as String,
            country: e['country'] as String,
            state: e['state'] as String,
            city: e['city'] as String,
            password: e['password'] as String)
      } else {
        Recruiter.create(
            firstName: e['firstName'] as String,
            lastName: e['lastName'] as String,
            username: e['lastName'] as String,
            country: e['county'] as String,
            state: e['state'] as String,
            city: e['city'] as String,
            password: e['password'] as String)
      }
      }).toList();
      return Future.wait(resultFutures);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a event:');
      return null;
    }
  }

  static Future<Event> get(int id) async {
    try {
      const sql = '''
        SELECT * FROM event 
        JOIN users ON event.owner=users.id
        WHERE event.id=? 
      ''';
      final result = (await ServerChannel.db.query(sql, [id])).first;
      User user;
      if (stringToUserType(result['type'] as String) == UserType.student) {
        user = Student.create(
            firstName: result['first_name'] as String,
            lastName: result['last_name'] as String,
            username: result['user_name'] as String,
            country: result['country'] as String,
            state: result['state'] as String,
            city: result['city'] as String,
            password: result['password'] as String);
      } else {
        user = Recruiter.create(
            firstName: result['firstName'] as String,
            lastName: result['lastName'] as String,
            username: result['lastName'] as String,
            country: result['county'] as String,
            state: result['state'] as String,
            city: result['city'] as String,
            password: result['password'] as String);
      }
      user.id = result['owner'] as int;
      return Event.create(
          owner: user,
          eventName: result['event_name'] as String,
          startDate: result['start_date'] as DateTime,
          endDate: result['end_date'] as DateTime)
        ..id = id;
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a event:');
      return null;
    }
  }
}
