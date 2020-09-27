import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:convert';
import 'package:ui/models/User.dart';

class Company {
  String name;

  Map<String, dynamic> toJson() {
    return {'name': name};
  }

  void fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }
}

class Institution {
  String name;
  String longName;

  Map<String, dynamic> toJson() {
    return {'name': name, 'longName': longName};
  }

  void fromJson(Map<String, dynamic> json) {
    name = json["name"];
    longName = json["longName"];
  }
}

class Field {
  String name;

  Map<String, dynamic> toJson() {
    return {'name': name};
  }

  void fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }
}

class Education {
  Institution institution;
  String degree;
  Field field;
  bool current;
  DateTime startDate;
  DateTime endDate;

  Education(
      {this.institution,
      this.degree,
      this.field,
      this.current,
      this.startDate,
      this.endDate});

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

  void fromJson(Map<String, dynamic> json) {
    institution = Institution()..fromJson(json['institution']);
    degree = json['degree'];
    field = Field()..fromJson(json['field']);
    current = json['current'];
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
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

  void fromJson(Map<String, dynamic> json) {
    company = Company()..fromJson(json['company']);
    jobTitle = json['jobTitle'];
    description = json['description'];
    current = json['current'];
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
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

  void fromJson(Map<String, dynamic> json) {
    company = Company()..fromJson(json['company']);
    title = json['title'];
    description = json['description'];
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
  }
}

class Skill {
  String title;

  Map<String, dynamic> toJson() {
    return {'title': title};
  }

  void fromJson(Map<String, dynamic> json) {
    title = json["title"];
  }
}

class Interest {
  String title;

  Map<String, dynamic> toJson() {
    return {'title': title};
  }

  void fromJson(Map<String, dynamic> json) {
    title = json["title"];
  }
}

class CardInfo {
  User user = User();
  List<Education> education = [];
  List<Work> work = [];
  List<Volunteering> volunteering = [];
  List<Skill> skills = [];
  List<Interest> interests = [];

  CardInfo(
      {this.user,
      this.education,
      this.work,
      this.volunteering,
      this.skills,
      this.interests});

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'education': education?.map((e) => e.toJson())?.toList(),
      'work': work?.map((e) => e.toJson())?.toList(),
      'volunteering': volunteering?.map((e) => e.toJson())?.toList(),
      'skills': skills?.map((e) => e.toJson())?.toList(),
      'interests': interests?.map((e) => e.toJson())?.toList()
    };
  }

  void fromJson(Map<String, dynamic> json) {
    user = User()..fromJson(json['user']);
    education = new List<Education>.from(json['education']
        .map((element) => Education()..fromJson(element))
        .toList());
    work = new List<Work>.from(
        json['work'].map((element) => Work()..fromJson(element)).toList());
    volunteering = new List<Volunteering>.from(json['volunteering']
        .map((element) => Volunteering()..fromJson(element))
        .toList());
    // skills = new List<Skill>.from(
    //     json['skills'].map((element) => Skill()..fromJson(element)).toList());
    // interests = new List<Interest>.from(json['interests']
    //     .map((element) => Interest()..fromJson(element))
    //     .toList());
  }
}

class CardInfoModel {
  // TODO strip whitespace from inputs
  final CardInfo _createUser = CardInfo();
  CardInfo get createUser => _createUser;

  Future<bool> createCard(String token) async {
    try {
      final res = await post('http://10.0.2.2:8888/api/cards',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(_createUser.toJson()));
      final body = json.decode(res.body);
      return body['success'] as bool;
    } catch (err) {
      print('An error occurred while trying to create a card:');
      print(err);
      return false;
    }
  }

  Future<CardInfo> fetchCardInfo(int id, String token) async {
    final response = await get(
      "http://10.0.2.2:8888/api/cards/$id",
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final body = json.decode(response.body);
    print("JSON RESPONSE");
    print(body);

    if (response.statusCode == 200) {
      print(body);
      return CardInfo()..fromJson(body);
    } else {
      throw Exception('Failed to load user info');
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
