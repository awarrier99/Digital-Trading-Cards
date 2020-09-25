import 'package:ui/models/CardInfo.dart';

import 'package:http/http.dart';

import 'dart:convert';

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

  void fromJson(Map<String, dynamic> map) {
    id = map['id'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    username = map['username'];
    country = map['country'];
    state = map['state'];
    city = map['city'];
    type = map['type'];
  }
}

class UserModel {
  User _currentUser;
  String _token;

  User get currentUser => _currentUser;
  String get token => _token;

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


  Future<bool> login() async { // TODO: add try/catch, strip whitespace
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

  void updateUser(User user) {
    _currentUser = user;
  }

  void updateToken(String token) {
    _token = token;
  }
}
