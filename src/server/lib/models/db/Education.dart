import 'package:meta/meta.dart';
import 'package:server/server.dart';

import 'Field.dart' as fld;
import 'Institution.dart';
import 'User.dart';

enum Degree {
  associate,
  bachelor,
  master,
  doctoral
}

String degreeToString(Degree degree) {
  switch (degree) {
    case Degree.associate:
      return 'Associate';
    case Degree.bachelor:
      return 'Bachelor\'s';
    case Degree.master:
      return 'Master\'s';
    default:
      return 'Doctoral';
  }
}

Degree stringToDegree(String string) {
  switch (string) {
    case 'Associate':
      return Degree.associate;
    case 'Bachelor\'s':
      return Degree.bachelor;
    case 'Master\'s':
      return Degree.master;
    default:
      return Degree.doctoral;
  }
}

class Education extends Serializable {
  Education();

  Education.create({
    @required this.user,
    @required this.institution,
    @required this.degree,
    @required this.field,
    @required this.current,
    @required this.startDate,
    this.endDate
  });

  int id;
  User user;
  Institution institution;
  Degree degree;
  fld.Field field;
  bool current;
  DateTime startDate;
  DateTime endDate;

  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'user': user.asMap(),
      'institution': institution.asMap(),
      'degree': degreeToString(degree),
      'field': field.asMap(),
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
    institution = Institution()
      ..readFromMap(object['institution'] as Map<String, dynamic>);
    degree = stringToDegree(object['degree'] as String);
    field = fld.Field()
      ..readFromMap(object['field'] as Map<String, dynamic>);
    current = object['current'] as bool;
    startDate = DateTime.parse(object['startDate'] as String);
    endDate = DateTime.parse(object['endDate'] as String);
  }

  Future<void> save() async {
    const sql = '''
      INSERT INTO education
      (user, institution, degree, field, current, start_date, end_date)
      VALUES (?, ?, ?, ?, ?, ?, ?)
    ''';
    await ServerChannel.db.query(sql, [
      user.id,
      institution.name,
      degreeToString(degree),
      field.name,
      current,
      startDate.toUtc(),
      endDate.toUtc()
    ]);
  }

  static Future<List<Education>> getByUser(User user) async {
    const sql = '''
      SELECT * FROM education
      WHERE user = ?
    ''';
    final results = await ServerChannel.db.query(sql, [user.id]);

    final resultFutures = results.map((e) async =>
        Education.create(
            user: user,
            institution: await Institution.get(e[2] as String),
            degree: stringToDegree(e[3] as String),
            field: fld.Field.create(name: e[4] as String),
            current: (e[5] as int) == 1,
            startDate: (e[6] as DateTime).toLocal(),
            endDate: (e[7] as DateTime)?.toLocal()
        )
          ..id = e[0] as int
    );
    return Future.wait(resultFutures);
  }
}
