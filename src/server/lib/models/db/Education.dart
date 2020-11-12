import 'package:meta/meta.dart';

import '../../server.dart';

enum Degree { associate, bachelor, master, doctoral }

// convert an enum to a string
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

// convert a string to an enum
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

// represents education experience for a user
class Education extends Serializable {
  Education();

  Education.create(
      {@required this.user,
      @required this.institution,
      @required this.degree,
      @required this.field,
      @required this.current,
      @required this.startDate,
      this.endDate});

  int id;
  User user;
  Institution institution;
  Degree degree;
  Field field;
  bool current;
  DateTime startDate;
  DateTime endDate;

  // serializes a class instance into a JSON response payload
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
    institution = Institution()
      ..readFromMap(object['institution'] as Map<String, dynamic>);
    degree = stringToDegree(object['degree'] as String);
    field = Field()..readFromMap(object['field'] as Map<String, dynamic>);
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

  // save or update a class instance in the database
  Future<void> save({bool allowUpdate = true}) async {
    try {
      String sql;
      final values = [
        user.id,
        institution.name,
        degreeToString(degree),
        field.name,
        current,
        startDate.toUtc(),
        endDate?.toUtc()
      ];
      if (id == null) {
        // if the id isn't set, create a new row
        sql = '''
          INSERT INTO education
          (user, institution, degree, field, current, start_date, end_date)
          VALUES (?, ?, ?, ?, ?, ?, ?)
        ''';
      } else if (allowUpdate) {
        // if the id is set, update the properties
        sql = '''
          UPDATE education
          SET institution = ?,
            degree = ?,
            field = ?,
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
          message:
              'An error occurred while trying to save user education info:');
    }
  }

  // delete a class instance from the database
  Future<void> delete() async {
    try {
      if (id == null) {
        print('Unsaved user education info cannot be deleted');
        return;
      }

      const sql = '''
        DELETE FROM education
        WHERE id = ?
      ''';

      await ServerChannel.db.query(sql, [id]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message:
              'An error occurred while trying to delete user education info:');
    }
  }

  // get all of a user's education info
  static Future<List<Education>> getByUser(User user) async {
    try {
      const sql = '''
        SELECT * FROM education
        WHERE user = ?
      ''';
      final results = await ServerChannel.db.query(sql, [user.id]);

      final resultFutures = results.map((e) async => Education.create(
          user: user,
          institution: await Institution.get(e['institution'] as String),
          degree: stringToDegree(e['degree'] as String),
          field: Field.create(
              name: e['field'] as String,
              abbreviation: e['abbreviation'] as String),
          current: (e['current'] as int) == 1,
          startDate: (e['start_date'] as DateTime).toLocal(),
          endDate: (e['end_date'] as DateTime)?.toLocal())
        ..id = e['id'] as int);
      return Future.wait(resultFutures);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message:
              'An error occurred while trying to get user education info:');
      return [];
    }
  }
}
