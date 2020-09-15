import 'package:meta/meta.dart';

import '../../server.dart';
import 'Company.dart';

enum UserType {
  student,
  recruiter
}

abstract class User extends Serializable {
  User({
    @required this.firstName,
    @required this.lastName,
    @required this.username,
    @required this.country,
    @required this.state,
    @required this.city,
    @required this.type
  });

  int id;
  String firstName;
  String lastName;
  String username;
  String country;
  String state;
  String city;
  UserType type;
}

class Student extends User {
  Student();

  Student.create({
    @required String firstName,
    @required String lastName,
    @required String username,
    @required String country,
    @required String state,
    @required String city,
    @required this.gpa
  }): super(
    firstName: firstName,
    lastName: lastName,
    username: username,
    country: country,
    state: state,
    city: city,
    type: UserType.student
  );

  double gpa;

  @override
  Map<String, dynamic> asMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "country": country,
      "state": state,
      "city": city,
      "type": UserType.student.toString(),
      "gpa": gpa
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    firstName = object['firstName'] as String;
    lastName = object['lastName'] as String;
    username = object['username'] as String;
    country = object['country'] as String;
    state = object['state'] as String;
    city = object['city'] as String;
    type = UserType.student;
    gpa = object['gpa'] as double;
  }
}

class Recruiter extends User {
  Recruiter();

  Recruiter.create({
    @required String firstName,
    @required String lastName,
    @required String username,
    @required String country,
    @required String state,
    @required String city,
    @required this.company,
    this.website
  }): super(
      firstName: firstName,
      lastName: lastName,
      username: username,
      country: country,
      state: state,
      city: city,
      type: UserType.recruiter
  );

  Company company;
  String website;

  @override
  Map<String, dynamic> asMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "country": country,
      "state": state,
      "city": city,
      "type": UserType.recruiter.toString(),
      "company": company,
      "website": website
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    firstName = object['firstName'] as String;
    lastName = object['lastName'] as String;
    username = object['username'] as String;
    country = object['country'] as String;
    state = object['state'] as String;
    city = object['city'] as String;
    type = UserType.recruiter;
    company = object['company'] as Company;
    website = object['website'] as String;
  }
}
