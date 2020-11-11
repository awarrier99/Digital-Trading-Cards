import 'dart:convert';
import 'package:http/http.dart';
import 'package:ui/models/CardInfo.dart';

// User is a model that will hold all information relevent to a users account information
class User {
  int id;
  String firstName;
  String lastName;
  String username;
  String country;
  String state;
  String city;
  String type;
  String password;

  double gpa;

  Company company;
  String website;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'country': country,
      'state': state,
      'city': city,
      'password': password,
      'type': type,
    };
    if (type == 'Student') {
      map.putIfAbsent('gpa', () => gpa);
    } else {
      map.putIfAbsent('company', () => company);
      map.putIfAbsent('website', () => website);
    }

    return map;
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    type = json['type'];
  }
}

// the user Model is used for making api calls regarding users account information
class UserModel {
  User _currentUser;
  String _token;

  User get currentUser => _currentUser;
  String get token => _token;

  // sends a post call to the API to create a user
  // token is a string that is used to validate that the api call is coming from our application
  Future<bool> createUser() async {
    try {
      final res = await post('http://10.0.2.2:8888/api/users',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: json.encode(_currentUser.toJson()));
      final body = json.decode(res.body);
      final success = body['success'];
      if (!success) return false;

      _currentUser.id = body['id'];
      _token = body['token'];
      return true;
    } catch (err) {
      return false;
    }
  }

  // logs in a user
  Future<bool> login() async {
    // TODO: add try/catch, strip whitespace
    final res = await post('http://10.0.2.2:8888/api/users/login',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: json.encode(_currentUser.toJson()));
    final body = json.decode(res.body);
    final success = body['success'];
    if (!success) return false;

    final token = body['token'] as String;
    _token = token;
    final user = body['user'];
    _currentUser = User()..fromJson(user);
    return true;
  }

  void empty() {
    _currentUser = null;
    _token = null;
  }

  void updateUser(User user) {
    _currentUser = user;
  }

  void updateToken(String token) {
    _token = token;
  }
}
