import 'package:meta/meta.dart';
import 'package:dbcrypt/dbcrypt.dart';

import '../../server.dart';
import 'Company.dart';

enum UserType { student, recruiter }

// convert an enum to a string
String userTypeToString(UserType userType) {
  switch (userType) {
    case UserType.student:
      return 'Student';
    default:
      return 'Recruiter';
  }
}

// hash a user's password
String hashPassword(String plainPass) {
  final String hashedPassword =
      DBCrypt().hashpw(plainPass, DBCrypt().gensalt());
  return hashedPassword;
}

// convert a string to an enum
UserType stringToUserType(String string) {
  switch (string) {
    case 'Student':
      return UserType.student;
    default:
      return UserType.recruiter;
  }
}

// represents an abstract user
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

  // based on the user type, invoke the respective serialization
  factory User.fromMap(Map<String, dynamic> map) {
    if (map['type'] == userTypeToString(UserType.student)) {
      return Student()..readFromMap(map);
    }
    return Recruiter()..readFromMap(map);
  }

  int id;
  String firstName;
  String lastName;
  String username;
  String country;
  String state;
  String city;
  String password;
  UserType type;

  // serializes a class instance into a JSON response payload
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

  // serializes the JSON request payload into a class instance
  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'] as int;
    firstName = object['firstName'] as String;
    lastName = object['lastName'] as String;
    username = object['username'] as String;
    country = object['country'] as String;
    state = object['state'] as String;
    city = object['city'] as String;
    type = stringToUserType(object['type'] as String);
    password = object['password'] as String;
  }

  // helper function to create a user from a database query
  static Future<User> _createFromQuery(dynamic key, String sqlKey) async {
    final sql = '''
      SELECT * FROM users
      WHERE $sqlKey = ?
    ''';

    final results = await ServerChannel.db.query(sql, [key]);
    if (results.isEmpty) {
      return null;
    }

    final userRow = results.first;
    final id = userRow['id'] as int;
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

  // get a user by id
  static Future<User> get(int id) async {
    try {
      return _createFromQuery(id, 'id');
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a user:');
      return null;
    }
  }

  // get a user by username
  static Future<User> getByUsername(String username) {
    try {
      return _createFromQuery(username, 'username');
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a user:');
      return null;
    }
  }

  // super function to save a class instance in the database
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

  // check a user's password
  Future<bool> checkAuth(String plaintext) async {
    try {
      return DBCrypt().checkpw(plaintext, password);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to authenticate a user:');
      return false;
    }
  }
}

// represents a student user
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

  // serializes a class instance into a JSON response payload
  @override
  Map<String, dynamic> asMap() {
    final userMap = super.asMap();
    return {...userMap, 'gpa': gpa};
  }

  // serializes the JSON request payload into a class instance
  @override
  void readFromMap(Map<String, dynamic> object) {
    super.readFromMap(object);
    type = UserType.student;
    gpa = object['gpa'] as double;
  }

  // save a class instance in the database
  @override
  Future<void> save() async {
    try {
      await super.save(); // invoke super save function
      const sql = '''
        INSERT INTO students
        (id, gpa)
        VALUES (?, ?)
      ''';
      await ServerChannel.db.query(sql, [id, gpa]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to save a student:');
    }
  }
}

// represents a recruiter user
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

  // serializes a class instance into a JSON response payload
  @override
  Map<String, dynamic> asMap() {
    final userMap = super.asMap();
    return {...userMap, 'company': company?.asMap(), 'website': website};
  }

  // serializes the JSON request payload into a class instance
  @override
  void readFromMap(Map<String, dynamic> object) {
    super.readFromMap(object);
    type = UserType.recruiter;
    final companyMap = object['company'] as Map<String, dynamic>;
    if (companyMap == null) {
      company = null;
    } else {
      company = Company()..readFromMap(companyMap);
    }
    website = object['website'] as String;
  }

  // save a class instance in the database
  @override
  Future<void> save() async {
    try {
      await super.save(); // invoke super save function
      const sql = '''
        INSERT INTO recruiters
        (id, company, website)
        VALUES (?, ?, ?)
      ''';
      await ServerChannel.db.query(sql, [id, company?.name, website]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to save a recruiter:');
    }
  }
}
