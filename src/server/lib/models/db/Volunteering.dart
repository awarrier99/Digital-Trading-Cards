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
      "id": id,
      "user": user.asMap(),
      "company": company.asMap(),
      "title": title,
      "description": description,
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
    title = object['title'] as String;
    description = object['description'] as String;
    startDate = DateTime.parse(object['startDate'] as String);
    endDate = DateTime.parse(object['endDate'] as String);
  }
}
