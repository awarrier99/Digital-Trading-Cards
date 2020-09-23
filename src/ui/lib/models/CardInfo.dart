import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:convert';

class Company {
  String name;

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

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
      'password': 'password',
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

class Institution {
  String name;
  String longName;

  Map<String, dynamic> toJson() {
    return {'name': name, 'longName': longName};
  }
}

class Field {
  String name;

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

class Education {
  Institution institution;
  String degree;
  Field field;
  bool current;
  DateTime startDate;
  DateTime endDate;

  Map<String, dynamic> toJson() {
    return {
      'institution': institution == null ? {} : institution.toJson(),
      'degree': degree,
      'field': field == null ? {} : field.toJson(),
      'current': current,
      'startDate': startDate == null ? null : startDate.toIso8601String(),
      'endDate': endDate == null ? null : endDate.toIso8601String()
    };
  }
}

class Work {
  Company company;
  String jobTitle;
  String description;
  bool current;
  DateTime startDate;
  DateTime endDate;

  Map<String, dynamic> toJson() {
    return {
      'company': company == null ? {} : company.toJson(),
      'jobTitle': jobTitle,
      'description': description,
      'current': current,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String()
    };
  }
}

class Volunteering {
  Company company;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;

  Map<String, dynamic> toJson() {
    return {
      'company': company == null ? {} : company.toJson(),
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String()
    };
  }
}

class Skill {
  String name;

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

class Interest {
  String name;

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

class CardInfo {
  User user = User();
  List<Education> education = [];
  List<Work> work = [];
  List<Volunteering> volunteering = [];
  List<Skill> skills = [];
  List<Interest> interests = [];

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'education': education.map((e) => e.toJson()),
      'work': work.map((e) => e.toJson()),
      'volunteering': volunteering.map((e) => e.toJson()),
      'skills': skills.map((e) => e.toJson()),
      'interests': interests.map((e) => e.toJson())
    };
  }
}

class CardInfoModel {
  final CardInfo _createUser = CardInfo();
  CardInfo get createUser => _createUser;

  Future<void> createCard() async {
    final res = await post('/api/cards', headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }, body: _createUser.toJson());
    print(json.decode(res.body));
  }

  void updateUser(User user) {
    _createUser.user = user;
  }

  void updateEducation(List<Education> education) {
    _createUser.education = education;
  }
}
