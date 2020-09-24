import 'package:ui/models/CardInfo.dart';

import 'package:http/http.dart';

import 'dart:convert';

class User {
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
}

class UserModel {
  User _currentuser;

  User get currentuser => _currentuser;

  Future<void> createUser() async {
    final res = await post('http://10.0.2.2:8888/api/users',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: json.encode(_currentuser.toJson()));
    print(json.decode(res.body));
  }

  
  void updateUser(User user) {
    _currentuser = user;
  }
}
