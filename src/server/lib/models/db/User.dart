import 'package:meta/meta.dart';

import '../../server.dart';
import 'Company.dart';

enum UserType {
  student,
  recruiter
}

String userTypeToString(UserType userType) {
  switch (userType) {
    case UserType.student:
      return 'Student';
    default:
      return 'Recruiter';
  }
}

UserType stringToUserType(String string) {
  switch (string) {
    case 'Student':
      return UserType.student;
    default:
      return UserType.recruiter;
  }
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

  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'country': country,
      'state': state,
      'city': city,
      'type': userTypeToString(type)
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
  }

  static Future<User> get(int id) async {
    const sql = '''
      SELECT * FROM users
      WHERE id = ?
    ''';
    final results = await ServerChannel.db.query(sql, [id]);
    if (results.isEmpty) {
      return null;
    }

    final userRow = results.first;
    if (stringToUserType(userRow[7] as String) == UserType.student) {
      const sql2 = '''
        SELECT * FROM students
        WHERE id = ?
      ''';
      final studentRow = (await ServerChannel.db.query(sql2, [id])).first;
      return Student.create(
          firstName: userRow[1] as String,
          lastName: userRow[2] as String,
          username: userRow[3] as String,
          country: userRow[4] as String,
          state: userRow[5] as String,
          city: userRow[6] as String,
          gpa: studentRow[1] as double
      )
          ..id = id;
    }

    const sql3 = '''
      SELECT * FROM recruiters
      WHERE id = ?
    ''';
    final recruiterRow = (await ServerChannel.db.query(sql3, [id])).first;
    return Recruiter.create(
        firstName: userRow[1] as String,
        lastName: userRow[2] as String,
        username: userRow[3] as String,
        country: userRow[4] as String,
        state: userRow[5] as String,
        city: userRow[6] as String,
        company: Company.create(name: recruiterRow[1] as String),
        website: recruiterRow[2] as String
    )
        ..id = id;
  }

  Future<void> save() async {
    const sql = '''
        INSERT INTO users
        (first_name, last_name, username, country, state, city, type)
        VALUES (?, ?, ?, ?, ?, ?, 'student')
      ''';
    final results = await ServerChannel.db.query(sql, [firstName, lastName, username, country, state, city]);
    id = results.insertId;
  }
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
    final userMap = super.asMap();
    return {
      ...userMap,
      'gpa': gpa
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    super.readFromMap(object);
    type = UserType.student;
    gpa = object['gpa'] as double;
  }

  @override
  Future<void> save() async {
    try {
      await super.save();
      const sql = '''
        INSERT INTO students
        (id, gpa)
        VALUES (?, ?)
      ''';
      await ServerChannel.db.query(sql, [id, gpa]);
    } catch (err) {
      print('An error occurred while trying to save the user:');
      print(err);
    }
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
    final userMap = super.asMap();
    return {
      ...userMap,
      'company': company,
      'website': website
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    super.readFromMap(object);
    type = UserType.recruiter;
    company = Company()
      ..readFromMap(object['company'] as Map<String, dynamic>);
    website = object['website'] as String;
  }

  @override
  Future<void> save() async {
    await super.save();
    const sql = '''
      INSERT INTO recruiters
      (id, company, website)
      VALUES (?, ?, ?)
    ''';
    await ServerChannel.db.query(sql, [id, company.name, website]);

  }
}
