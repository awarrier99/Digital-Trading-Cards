// This file holds relevant classes for connecting to the back end for the users trading card
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ui/models/User.dart';

class Company {
  String name;

  Map<String, dynamic> toJson() {
    return {'name': name};
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    name = json['name'];
  }
}

class Institution {
  String name;
  String longName;

  Map<String, dynamic> toJson() {
    return {'name': name, 'longName': longName};
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    name = json['name'];
    longName = json['longName'];
  }
}

class Field {
  String abbreviation;
  String name;

  Map<String, dynamic> toJson() {
    return {'abbreviation': abbreviation, 'name': name};
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    abbreviation = json['abbreviation'];
    name = json['name'];
  }
}

class Education {
  int id;
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
      'id': id,
      'institution': institution?.toJson(),
      'degree': degree,
      'field': field?.toJson(),
      'current': current,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String()
    };
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    id = json['id'];
    institution = Institution()..fromJson(json['institution']);
    degree = json['degree'];
    field = Field()..fromJson(json['field']);
    current = json['current'];
    startDate = DateTime.parse(json['startDate']);
    endDate = json['endDate'] == null ? null : DateTime.parse(json['endDate']);
  }
}

class Work {
  int id;
  Company company;
  String jobTitle;
  String description;
  bool current;
  DateTime startDate;
  DateTime endDate;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company == null ? {} : company.toJson(),
      'jobTitle': jobTitle,
      'description': description,
      'current': current,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String()
    };
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    id = json['id'];
    company = Company()..fromJson(json['company']);
    jobTitle = json['jobTitle'];
    description = json['description'];
    current = json['current'];
    startDate =
        json['startDate'] == null ? null : DateTime.parse(json['startDate']);
    endDate = json['endDate'] == null ? null : DateTime.parse(json['endDate']);
  }
}

class Volunteering {
  int id;
  Company company;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company == null ? {} : company.toJson(),
      'title': title,
      'description': description,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String()
    };
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    id = json['id'];
    company = Company()..fromJson(json['company']);
    title = json['title'];
    description = json['description'];
    startDate =
        json['startDate'] == null ? null : DateTime.parse(json['startDate']);
    endDate = json['endDate'] == null ? null : DateTime.parse(json['endDate']);
  }
}

class Skill {
  String title;

  Map<String, dynamic> toJson() {
    return {'title': title};
  }

  void fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }
}

class Interest {
  String title;

  Map<String, dynamic> toJson() {
    return {'title': title};
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    title = json['title'];
  }
}

class UserSkill {
  int id;
  Skill skill = Skill();

  Map<String, dynamic> toJson() {
    return {'id': id, 'skill': skill.toJson()};
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    id = json['id'];
    skill = Skill()..fromJson(json['skill']);
  }
}

class UserInterest {
  int id;
  Interest interest = Interest();

  Map<String, dynamic> toJson() {
    return {'id': id, 'interest': interest.toJson()};
  }

  void fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    id = json['id'];
    interest = Interest()..fromJson(json['interest']);
  }
}

// CardInfo is a model that will hold all information relevent to a users trading card
class CardInfo {
  User user = User();
  List<Education> education = [];
  List<Work> work = [];
  List<Volunteering> volunteering = [];
  List<UserSkill> skills = [];
  List<UserInterest> interests = [];

  CardInfo(
      {this.user,
      this.education,
      this.work,
      this.volunteering,
      this.skills,
      this.interests});

  // Define that two persons are equal if their SSNs are equal
  bool operator ==(other) {
    return (other is CardInfo && other.user == user);
  }

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
    json = json ?? {};
    user = User()..fromJson(json['user']);
    education = (json['education'] as List)
        ?.map((element) => Education()..fromJson(element))
        ?.toList();
    work = (json['work'] as List)
        ?.map((element) => Work()..fromJson(element))
        ?.toList();
    volunteering = (json['volunteering'] as List)
        ?.map((element) => Volunteering()..fromJson(element))
        ?.toList();
    skills = (json['skills'] as List)
        ?.map((element) => UserSkill()..fromJson(element))
        ?.toList();
    interests = (json['interests'] as List)
        ?.map((element) => UserInterest()..fromJson(element))
        ?.toList();
  }

  // checks if the users card has any of the interests that are in the interestsFilter parameter
  bool satisfiesFilters(List<String> interestsFilter) {
    for (String interest in interestsFilter) {
      if (interests.contains(interest)) {
        return true;
      }
    }
    return false;
  }
}

// the card Info Model is used for making api calls regarding cards
class CardInfoModel {
  // TODO strip whitespace from inputs
  final CardInfo _currentUserCardInfo = CardInfo();
  CardInfo get currentUserCardInfo => _currentUserCardInfo;

  bool isEditing = false;

  Map<String, List<dynamic>> deleteLists = {
    'education': <Education>[],
    'work': <Work>[],
    'volunteering': <Volunteering>[],
    'skills': <UserSkill>[],
    'interests': <UserInterest>[]
  };

  // sends a post call to the API to create a card
  // token is a string that is used to validate that the api call is coming from our application
  Future<bool> createCard(String token) async {
    try {
      final res = await post('http://34.75.44.166:8888/api/cards',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(_currentUserCardInfo.toJson()));
      final body = json.decode(res.body);
      return body['success'];
    } catch (err) {
      // TODO: Improve Error handling
      print('An error occurred while trying to create a card:');
      print(err);
      return false;
    }
  }

  // Sends a put call to the API to update a card
  // id: the id of the user that will be updated
  // token: string that is used to validate that the api call is coming from our application
  Future<bool> updateCard(int id, String token) async {
    try {
      final res = await put('http://34.75.44.166:8888/api/cards/$id',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            'cardInfo': _currentUserCardInfo.toJson(),
            'deleteLists': deleteLists
          }));
      final body = json.decode(res.body);
      return body['success'];
    } catch (err) {
      // TODO: Improve Error handling
      print('An error occurred while trying to update a card:');
      print(err);
      return false;
    }
  }

  // makes a call to the API to get the card info of a specific user
  // id: the id of the user that you want to get the information of
  // token: string that is used to validate that the api call is coming from our application
  Future<CardInfo> fetchCardInfo(int id, String token,
      {isCurrentUser: false}) async {
    final response =
        await get('http://34.75.44.166:8888/api/cards/$id', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final body = json.decode(response.body);
    if (response.statusCode == 200) {
      if (isCurrentUser) {
        _currentUserCardInfo.fromJson(body);
        return currentUserCardInfo;
      }
      return CardInfo()..fromJson(body);
    } else {
      return null;
    }
  }

  // makes a call to the API to get the card info of a speciific user
  // id: the username of the user that you want to get the information of
  // token: string that is used to validate that the api call is coming from our application
  Future<CardInfo> fetchCardInfoByUsername(String username, String token,
      {isCurrentUser: false}) async {
    final response = await get(
      'http://34.75.44.166:8888/api/cards/$username',
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final body = json.decode(response.body);
    if (response.statusCode == 200) {
      if (isCurrentUser) {
        _currentUserCardInfo.fromJson(body);
        return currentUserCardInfo;
      }
      return CardInfo()..fromJson(body);
    } else {
      return null;
    }
  }

  void updateUser(User user) {
    _currentUserCardInfo.user = user;
  }

  void updateEducation(List<Education> education) {
    _currentUserCardInfo.education = education;
  }

  void updateWork(List<Work> work) {
    _currentUserCardInfo.work = work;
  }

  void updateVolunteering(List<Volunteering> volunteering) {
    _currentUserCardInfo.volunteering = volunteering;
  }

  void updateSkills(List<UserSkill> skills) {
    _currentUserCardInfo.skills = skills;
  }

  void updateInterests(List<UserInterest> interests) {
    _currentUserCardInfo.interests = interests;
  }

  void empty() {
    _currentUserCardInfo.fromJson({});
    isEditing = false;
  }
}
