import 'package:meta/meta.dart';

import '../../server.dart';
import 'Company.dart';
import 'User.dart';

class Work extends Serializable {
  Work();

  Work.create(
      {@required this.user,
      @required this.company,
      @required this.jobTitle,
      @required this.current,
      @required this.startDate,
      this.endDate,
      this.description});

  int id;
  User user;
  Company company;
  String jobTitle;
  String description;
  bool current;
  DateTime startDate;
  DateTime endDate;

  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'user': user.asMap(),
      'company': company.asMap(),
      'jobTitle': jobTitle,
      'description': description,
      'current': current,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String()
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'] as int;
    if (user == null) {
      final userMap = object['user'] as Map<String, dynamic>;
      user = User.fromMap(userMap);
    }
    company = Company()..readFromMap(object['company'] as Map<String, dynamic>);
    jobTitle = object['jobTitle'] as String;
    description = object['description'] as String;
    current = object['current'] as bool;
    final startDateStr = object['startDate'] as String;
    startDate = startDateStr == null || startDateStr.isEmpty
        ? null
        : DateTime.parse(startDateStr);
    final endDateStr = object['endDate'] as String;
    endDate = endDateStr == null || endDateStr.isEmpty
        ? null
        : DateTime.parse(endDateStr);
  }

  Future<void> save({bool allowUpdate = true}) async {
    try {
      String sql;
      final values = [
        user.id,
        company.name,
        jobTitle,
        description,
        current,
        startDate.toUtc(),
        endDate?.toUtc()
      ];
      if (id == null) {
        sql = '''
          INSERT INTO work
          (user, company, job_title, description, current, start_date, end_date)
          VALUES (?, ?, ?, ?, ?, ?, ?)
        ''';
      } else if (allowUpdate) {
        sql = '''
          UPDATE work
          SET company = ?,
            job_title = ?,
            description = ?,
            current = ?,
            start_date = ?,
            end_date = ?
          WHERE id = ?
        ''';
        values.removeAt(0);
        values.add(id);
      } else {
        return;
      }

      final results = await ServerChannel.db.query(sql, values);
      id ??= results.insertId;
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to save user work info:');
    }
  }

  Future<void> delete() async {
    try {
      if (id == null) {
        print('Unsaved user work info cannot be deleted');
        return;
      }

      const sql = '''
        DELETE FROM work
        WHERE id = ?
      ''';

      await ServerChannel.db.query(sql, [id]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to delete user work info:');
    }
  }

  static Future<List<Work>> getByUser(User user) async {
    try {
      const sql = '''
        SELECT * FROM work
        WHERE user = ?
      ''';
      final results = await ServerChannel.db.query(sql, [user.id]);

      return results
          .map((e) => Work.create(
                user: user,
                company: Company.create(name: e['company'] as String),
                jobTitle: e['job_title'] as String,
                description: e['description'] as String,
                current: (e['current'] as int) == 1,
                startDate: (e['start_date'] as DateTime).toLocal(),
                endDate: (e['end_date'] as DateTime)?.toLocal(),
              )..id = e['id'] as int)
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get user work info:');
      return [];
    }
  }
}
