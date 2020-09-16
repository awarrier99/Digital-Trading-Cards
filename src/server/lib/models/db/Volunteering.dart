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
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String()
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
    startDate = DateTime.parse(object['startDate'] as String);
    endDate = DateTime.parse(object['endDate'] as String);
  }

  Future<void> save() async {
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
      startDate.toUtc(),
      endDate.toUtc()
    ]);
  }

  static Future<List<Volunteering>> getByUser(User user) async {
    const sql = '''
      SELECT * FROM volunteering
      WHERE user = ?
    ''';
    final results = await ServerChannel.db.query(sql, [user.id]);

    final resultFutures = results.map((e) async =>
    Volunteering.create(
      user: user,
      company: Company.create(name: e[2] as String),
      title: e[3] as String,
      description: e[4] as String,
      startDate: (e[5] as DateTime).toLocal(),
      endDate: (e[6] as DateTime).toLocal(),
    )
      ..id = e[0] as int
    );
    return Future.wait(resultFutures);
  }
}
