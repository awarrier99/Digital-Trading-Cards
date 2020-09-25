import 'package:meta/meta.dart';

import '../../server.dart';
import 'Company.dart';
import 'User.dart';

class Volunteering extends Serializable {
  Volunteering();

  Volunteering.create({
    @required this.user,
    @required this.company,
    this.title,
    this.description,
    this.startDate,
    this.endDate
  });

  int id;
  User user;
  Company company;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;

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

  @override
  void readFromMap(Map<String, dynamic> object) {
    if (user == null) {
      final userMap = object['user'] as Map<String, dynamic>;
      if (stringToUserType(userMap['type'] as String) == UserType.student) {
        user = Student()
          ..readFromMap(userMap);
      } else {
        user = Recruiter()
          ..readFromMap(userMap);
      }
    }
    company = Company()
    ..readFromMap(object['company'] as Map<String, dynamic>);
    title = object['title'] as String;
    description = object['description'] as String;
    final startDateStr = object['startDate'] as String;
    startDate = startDateStr == null || startDateStr.isEmpty ? null : DateTime.parse(startDateStr);
    final endDateStr = object['endDate'] as String;
    endDate = endDateStr == null || endDateStr.isEmpty ? null : DateTime.parse(endDateStr);
  }

  Future<void> save() async {
    try {
      const sql = '''
        INSERT INTO volunteering
        (user, company, title, description, start_date, end_date)
        VALUES (?, ?, ?, ?, ?, ?)
      ''';
      await ServerChannel.db.query(sql, [
        user.id,
        company.name,
        title,
        description,
        startDate?.toUtc(),
        endDate?.toUtc()
      ]);
    } catch (err, stackTrace) {
      logError(err, stackTrace: stackTrace, message: 'An error occurred while trying to save user volunteering info:');
    }
  }

  static Future<List<Volunteering>> getByUser(User user) async {
    try {
      const sql = '''
        SELECT * FROM volunteering
        WHERE user = ?
      ''';
      final results = await ServerChannel.db.query(sql, [user.id]);

      final resultFutures = results.map((e) async =>
      Volunteering.create(
        user: user,
        company: Company.create(name: e['company'] as String),
        title: e['title'] as String,
        description: e['description'] as String,
        startDate: (e['start_date'] as DateTime)?.toLocal(),
        endDate: (e['end_date'] as DateTime)?.toLocal(),
      )
        ..id = e['id'] as int
      );
      return Future.wait(resultFutures);
    } catch (err, stackTrace) {
      logError(err, stackTrace: stackTrace, message: 'An error occurred while trying to get user volunteering info:');
      return [];
    }
  }
}
