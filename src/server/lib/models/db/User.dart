import 'package:meta/meta.dart';
import 'package:dbcrypt/dbcrypt.dart';

import '../../server.dart';
import 'Company.dart';

enum UserType { student, recruiter }

DBCrypt dbCrypt;
String userTypeToString(UserType userType) {
  switch (userType) {
    case UserType.student:
      return 'Student';
    default:
      return 'Recruiter';
  }
}

String hashPassword(String plainPass) {
  final String hashedPassword =
      DBCrypt().hashpw(plainPass, DBCrypt().gensalt());
  return hashedPassword;
}

UserType stringToUserType(String string) {
  switch (string) {
    case 'Student':
      return UserType.student;
    default:
      return UserType.recruiter;
  }
}

class User extends Serializable {
  User(
      {@required this.firstName,
      @required this.lastName,
      @required this.username,
      @required this.country,
      @required this.state,
      @required this.city,
      @required this.password,
      @required this.type});

  int id;
  String firstName;
  String lastName;
  String username;
  String country;
  String state;
  String city;
  String password;
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
    type = stringToUserType(object['type'] as String);
    password = object['password'] as String;
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
    if (stringToUserType(userRow['type'] as String) == UserType.student) {
      const sql2 = '''
        SELECT * FROM students
        WHERE id = ?
      ''';
      final studentRow = (await ServerChannel.db.query(sql2, [id])).first;
      return Student.create(
          firstName: userRow['first_name'] as String,
          lastName: userRow['last_name'] as String,
          username: userRow['username'] as String,
          country: userRow['country'] as String,
          state: userRow['state'] as String,
          city: userRow['city'] as String,
          password: userRow['password'] as String,
          gpa: studentRow['gpa'] as double)
        ..id = id;
    }

    const sql3 = '''
      SELECT * FROM recruiters
      WHERE id = ?
    ''';
    final recruiterRow = (await ServerChannel.db.query(sql3, [id])).first;
    return Recruiter.create(
        firstName: userRow['first_name'] as String,
        lastName: userRow['last_name'] as String,
        username: userRow['username'] as String,
        country: userRow['country'] as String,
        state: userRow['state'] as String,
        city: userRow['city'] as String,
        password: userRow['password'] as String,
        company: Company.create(name: recruiterRow['company'] as String),
        website: recruiterRow['website'] as String)
      ..id = id;
  }

  static Future<User> getLoginCreds(String username) {}

  Future<void> save() async {
    const sql = '''
        INSERT INTO users
        (first_name, last_name, username, country, state, city, password, type)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      ''';
    final results = await ServerChannel.db.query(sql, [
      firstName,
      lastName,
      username,
      country,
      state,
      city,
      hashPassword(password),
      userTypeToString(type)
    ]);
    id = results.insertId;
  }

  Future<bool> checkAuth() async {
    const sql = '''
      SELECT password FROM users
      WHERE username = ?
    ''';
    final results = (await ServerChannel.db.query(sql, [username])).first;
    String hashedPass = results['password'].toString();
    if (results.isEmpty) {
      return false;
    }
    var isCorrect = new DBCrypt().checkpw(password, hashedPass);
    print(isCorrect);
    return isCorrect;
  }
}

class Student extends User {
  Student();

  Student.create(
      {@required String firstName,
      @required String lastName,
      @required String username,
      @required String country,
      @required String state,
      @required String city,
      @required String password,
      this.gpa})
      : super(
            firstName: firstName,
            lastName: lastName,
            username: username,
            country: country,
            state: state,
            city: city,
            password: password,
            type: UserType.student);

  factory Student.of(User user) {
    return Student.create(
        firstName: user.firstName,
        lastName: user.lastName,
        username: user.username,
        country: user.country,
        state: user.state,
        city: user.city,
        password: user.password);
  }

  double gpa;

  @override
  Map<String, dynamic> asMap() {
    final userMap = super.asMap();
    return {...userMap, 'gpa': gpa};
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

  Recruiter.create(
      {@required String firstName,
      @required String lastName,
      @required String username,
      @required String country,
      @required String state,
      @required String city,
      @required String password,
      this.company,
      this.website})
      : super(
            firstName: firstName,
            lastName: lastName,
            username: username,
            country: country,
            state: state,
            city: city,
            password: password,
            type: UserType.recruiter);

  factory Recruiter.of(User user) {
    return Recruiter.create(
        firstName: user.firstName,
        lastName: user.lastName,
        username: user.username,
        country: user.country,
        state: user.state,
        city: user.city,
        password: user.password);
  }

  Company company;
  String website;

  @override
  Map<String, dynamic> asMap() {
    final userMap = super.asMap();
    return {...userMap, 'company': company, 'website': website};
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    super.readFromMap(object);
    type = UserType.recruiter;
    company = Company()..readFromMap(object['company'] as Map<String, dynamic>);
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
