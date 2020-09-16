import 'package:meta/meta.dart';

import '../../server.dart';
import '../db/models.dart';

class CardInfo extends Serializable {
  CardInfo({
    @required this.user,
    @required this.education,
    @required this.work,
    @required this.volunteering,
    @required this.skills,
    @required this.interests
  });

  User user;
  List<Education> education;
  List<Work> work;
  List<Volunteering> volunteering;
  List<Skill> skills;
  List<Interest> interests;

  @override
  Map<String, dynamic> asMap() {
    return {
      "user": user.asMap(),
      "education": education.map((e) => e.asMap()
        ..update('field', (value) => value['name'])
        ..remove('user'))
          .toList(),
      "work": work.map((e) => e.asMap()
        ..update('company', (value) => value['name'])
        ..remove('user'))
          .toList(),
      "volunteering": volunteering.map((e) => e.asMap()
        ..update('company', (value) => value['name'])
        ..remove('user'))
          .toList(),
      "skills": skills.map((e) => e.title)
          .toList(),
      "interests": interests.map((e) => e.title)
          .toList()
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    final userMap = object['user'] as Map<String, dynamic>;
    if (userMap['type'] == UserType.student.toString()) {
      user = Student()
      ..readFromMap(userMap);
    } else {
      user = Recruiter()
          ..readFromMap(userMap);
    }
    final educationList = object['education'] as List;
    education = educationList.map((e) => Education()
      ..user = user
      ..readFromMap(e as Map<String, dynamic>))
        .toList();
    final workList = object['work'] as List;
    work = workList.map((e) => Work()
      ..user = user
      ..readFromMap(e as Map<String, dynamic>))
        .toList();
    final volunteeringList = object['volunteering'] as List;
    volunteering = volunteeringList.map((e) => Volunteering()
      ..user = user
      ..readFromMap(e as Map<String, dynamic>))
        .toList();
    final skillsList = object['skills'] as List;
    skills = skillsList.map((e) => Skill()
      ..readFromMap(e as Map<String, dynamic>))
        .toList();
    final interestsList = object['interests'] as List;
    interests = interestsList.map((e) => Interest()
      ..readFromMap(e as Map<String, dynamic>))
        .toList();
  }

  static Future<CardInfo> get(User user) async {
    return CardInfo(
        user: user,
        education: await Education.getByUser(user),
        work: await Work.getByUser(user),
        volunteering: await Volunteering.getByUser(user),
        skills: await Skill.getByUser(user),
        interests: await Interest.getByUser(user)
    );
  }
}
