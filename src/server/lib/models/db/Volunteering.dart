import 'package:meta/meta.dart';

import '../../server.dart';
import 'Company.dart';
import 'User.dart';

// represents a user's volunteering info
class Volunteering extends Serializable {
  Volunteering();

  Volunteering.create(
      {@required this.user,
      @required this.company,
      this.title,
      this.description,
      this.startDate,
      this.endDate});

  int id;
  User user;
  Company company;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;

  // serializes a class instance into a JSON response payload
  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'user': user.asMap(),
      'company': company.asMap(),
      'title': title,
      'description': description,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String()
    };
  }

  // serializes the JSON request payload into a class instance
  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'] as int;
    if (user == null) {
      final userMap = object['user'] as Map<String, dynamic>;
      user = User.fromMap(userMap);
    }
    company = Company()..readFromMap(object['company'] as Map<String, dynamic>);
    title = object['title'] as String;
    description = object['description'] as String;
    final startDateStr = object['startDate'] as String;
    startDate = startDateStr == null || startDateStr.isEmpty
        ? null
        : DateTime.parse(startDateStr);
    final endDateStr = object['endDate'] as String;
    endDate = endDateStr == null || endDateStr.isEmpty
        ? null
        : DateTime.parse(endDateStr);
  }

  // save or update a class instance in the database
  Future<void> save({bool allowUpdate = true}) async {
    try {
      String sql;
      final values = [
        user.id,
        company.name,
        title,
        description,
        startDate?.toUtc(),
        endDate?.toUtc()
      ];
      if (id == null) {
        sql = '''
          INSERT INTO volunteering
          (user, company, title, description, start_date, end_date)
          VALUES (?, ?, ?, ?, ?, ?)
        ''';
      } else if (allowUpdate) {
        sql = '''
          UPDATE volunteering
          SET company = ?,
            title = ?,
            description = ?,
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
          message:
              'An error occurred while trying to save user volunteering info:');
    }
  }

  // delete a class instance in the database
  Future<void> delete() async {
    try {
      if (id == null) {
        print('Unsaved user volunteering info cannot be deleted');
        return;
      }

      const sql = '''
        DELETE FROM volunteering
        WHERE id = ?
      ''';

      await ServerChannel.db.query(sql, [id]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message:
              'An error occurred while trying to delete user volunteering info:');
    }
  }

  // get a list of a user's volunteering info
  static Future<List<Volunteering>> getByUser(User user) async {
    try {
      const sql = '''
        SELECT * FROM volunteering
        WHERE user = ?
      ''';
      final results = await ServerChannel.db.query(sql, [user.id]);

      return results
          .map((e) => Volunteering.create(
                user: user,
                company: Company.create(name: e['company'] as String),
                title: e['title'] as String,
                description: e['description'] as String,
                startDate: (e['start_date'] as DateTime)?.toLocal(),
                endDate: (e['end_date'] as DateTime)?.toLocal(),
              )..id = e['id'] as int)
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message:
              'An error occurred while trying to get user volunteering info:');
      return [];
    }
  }
}
