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
      "id": id,
      "user": user.asMap(),
      "company": company.asMap(),
      "jobTitle": jobTitle,
      "description": description,
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
    company = Company()
      ..readFromMap(object['company'] as Map<String, dynamic>);
    jobTitle = object['jobTitle'] as String;
    description = object['description'] as String;
    current = object['current'] as bool;
    startDate = DateTime.parse(object['startDate'] as String);
    endDate = DateTime.parse(object['endDate'] as String);
  }
}
