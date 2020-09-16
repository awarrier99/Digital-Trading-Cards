import 'package:meta/meta.dart';

import '../../server.dart';
import 'Company.dart';
import 'User.dart';

class Work extends Serializable {
  Work();

  Work.create({
    @required this.user,
    @required this.company,
    @required this.jobTitle,
    @required this.current,
    @required this.startDate,
    this.endDate,
    this.description
  });

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
    jobTitle = object['jobTitle'] as String;
    description = object['description'] as String;
    current = object['current'] as bool;
    startDate = DateTime.parse(object['startDate'] as String);
    endDate = DateTime.parse(object['endDate'] as String);
  }

  Future<void> save() async {
    const sql = '''
      INSERT INTO work
      (user, company, job_title, description, current, start_date, end_date)
      VALUES (?, ?, ?, ?, ?, ?, ?)
    ''';
    await ServerChannel.db.query(sql, [
      user.id,
      company.name,
      jobTitle,
      description,
      current,
      startDate.toUtc(),
      endDate.toUtc()
    ]);
  }

  static Future<List<Work>> getByUser(User user) async {
    const sql = '''
      SELECT * FROM work
      WHERE user = ?
    ''';
    final results = await ServerChannel.db.query(sql, [user.id]);

    final resultFutures = results.map((e) async =>
        Work.create(
            user: user,
            company: Company.create(name: e[2] as String),
            jobTitle: e[3] as String,
            description: e[4] as String,
            current: (e[5] as int) == 1,
            startDate: (e[6] as DateTime).toLocal(),
          endDate: (e[7] as DateTime).toLocal(),
        )
          ..id = e[0] as int
    );
    return Future.wait(resultFutures);
  }
}
