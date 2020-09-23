import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:convert';

class Company {
  String name;
  
  Map<String, dynamic> toJson() {
    return {
      'name': name
    };
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
      'type': type
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
    return {
      'name': name,
      'longName': longName
    };
  }
}

class Field {
  String name;
  
  Map<String, dynamic> toJson() {
    return {
      'name': name
    };
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
    return {
      'name': name
    };
  }
}

class Interest {
  String name;
  
  Map<String, dynamic> toJson() {
    return {
      'name': name
    };
  }
}

class CardInfo {
  final User user = User();
  final List<Education> education = [];
  final List<Work> work = [];
  final List<Volunteering> volunteering = [];
  final List<Skill> skills = [];
  final List<Interest> interests = [];

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
  final CardInfo createUser = CardInfo();

  Future<void> createCard() async {
    final res = await post('/api/cards', headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }, body: createUser.toJson());
    print(json.decode(res.body));
  }

  void updateUser({
    String firstName,
    String lastName,
    String username,
    String country,
    String state,
    String city,
    String type,
    double gpa,
    String company,
    String website
  }) {
    if (firstName != null) createUser.user.firstName = firstName;
    if (lastName != null) createUser.user.lastName = lastName;
    if (username != null) createUser.user.username = username;
    if (country != null) createUser.user.country = country;
    if (state != null) createUser.user.state = state;
    if (city != null) createUser.user.city = city;
    if (type != null) createUser.user.type = type;
    if (gpa != null) createUser.user.gpa = gpa;
    if (company != null) createUser.user.company = Company()
      ..name = company;
    if (website != null) createUser.user.website = website;
  }
}
