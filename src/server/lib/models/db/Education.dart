import 'package:meta/meta.dart';
import 'package:server/server.dart';

import 'User.dart';

enum Degree {
  associate,
  bachelor,
  master,
  doctoral
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
  String institution;
  Degree degree;
  String field;
  bool current;
  DateTime startDate;
  DateTime endDate;

  @override
  Map<String, dynamic> asMap() {
    return {
      "id": id,
      "user": user.asMap(),
      "institution": institution,
      "degree": degree.toString(),
      "field": field,
      "current": current,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String()
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    if (user == null) {
      final userMap = object['user'] as Map<String, dynamic>;
      if (userMap['type'] == UserType.student.toString()) {
        user = Student()
          ..readFromMap(userMap);
      } else {
        user = Recruiter()
          ..readFromMap(userMap);
      }
    }
    institution = object['institution'] as String;
    final degreeString = object['degree'] as String;
    degree = Degree.values
        .firstWhere((element) => degreeString == element.toString());
    field = object['field'] as String;
    current = object['current'] as bool;
    startDate = DateTime.parse(object['startDate'] as String);
    endDate = DateTime.parse(object['endDate'] as String);
  }
}
