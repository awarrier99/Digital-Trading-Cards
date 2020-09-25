import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:convert';
import 'package:ui/models/User.dart';

class Company {
  String name;

  Map<String, dynamic> toJson() {
    return {'name': name};
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
      'institution': institution?.toJson(),
      'degree': degree,
      'field': field?.toJson(),
      'current': current,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String()
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
      'endDate': endDate?.toIso8601String()
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
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String()
    };
  }
}

class Skill {
  String title;

  Map<String, dynamic> toJson() {
    return {'title': title};
  }
}

class Interest {
  String title;

  Map<String, dynamic> toJson() {
    return {'title': title};
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
      'education': education.map((e) => e.toJson()).toList(),
      'work': work.map((e) => e.toJson()).toList(),
      'volunteering': volunteering.map((e) => e.toJson()).toList(),
      'skills': skills.map((e) => e.toJson()).toList(),
      'interests': interests.map((e) => e.toJson()).toList()
    };
  }
}

class CardInfoModel { // TODO strip whitespace from inputs
  final CardInfo _createUser = CardInfo();
  CardInfo get createUser => _createUser;

  Future<bool> createCard() async {
    try {
      print(_createUser.toJson());
      final res = await post('http://10.0.2.2:8888/api/cards', headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }, body: json.encode(_createUser.toJson()));
      final body = json.decode(res.body);
      return body['success'] as bool;
    } catch (err) {
      print('An error occurred while trying to create a card:');
      print(err);
      return false;
    }
  }

  void updateUser(User user) {
    _createUser.user = user;
  }

  void updateEducation(List<Education> education) {
    _createUser.education = education;
  }

  void updateWork(List<Work> work) {
    _createUser.work = work;
  }

  void updateVolunteering(List<Volunteering> volunteering) {
    _createUser.volunteering = volunteering;
  }

  void updateSkills(List<Skill> skills) {
    _createUser.skills = skills;
  }

  void updateInterests(List<Interest> interests) {
    _createUser.interests = interests;
  }
}
