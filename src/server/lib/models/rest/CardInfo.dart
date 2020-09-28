import 'package:meta/meta.dart';

import '../../server.dart';

class CardInfo extends Serializable {
  CardInfo(
      {@required this.user,
      @required this.education,
      @required this.work,
      @required this.volunteering,
      @required this.skills,
      @required this.interests});

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
      "education": education.map((e) => e.asMap()..remove('user')).toList(),
      "work": work.map((e) => e.asMap()..remove('user')).toList(),
      "volunteering":
          volunteering.map((e) => e.asMap()..remove('user')).toList(),
      "skills": skills.map((e) => e.title).toList(),
      "interests": interests.map((e) => e.title).toList()
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    final userMap = object['user'] as Map<String, dynamic>;
    if (userMap['type'] == userTypeToString(UserType.student)) {
      user = Student()..readFromMap(userMap);
    } else {
      user = Recruiter()..readFromMap(userMap);
    }
    final educationList = object['education'] as List;
    education = educationList
        .map((e) => Education()
          ..user = user
          ..readFromMap(e as Map<String, dynamic>))
        .toList();
    final workList = object['work'] as List;
    work = workList
        .map((e) => Work()
          ..user = user
          ..readFromMap(e as Map<String, dynamic>))
        .toList();
    final volunteeringList = object['volunteering'] as List;
    volunteering = volunteeringList
        .map((e) => Volunteering()
          ..user = user
          ..readFromMap(e as Map<String, dynamic>))
        .toList();
    final skillsList = object['skills'] as List;
    skills = skillsList
        .map((e) => Skill()..readFromMap(e as Map<String, dynamic>))
        .toList();
    final interestsList = object['interests'] as List;
    interests = interestsList
        .map((e) => Interest()..readFromMap(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> create(CardInfo cardInfo) async {
    final List<Future> futures = [];
    await cardInfo.user.save();
    futures.add(Future.forEach(cardInfo.education, (Education e) => e.save()));
    futures.add(Future.forEach(cardInfo.work, (Work e) => e.save()));
    futures.add(
        Future.forEach(cardInfo.volunteering, (Volunteering e) => e.save()));
    futures.add(Future.forEach(cardInfo.skills,
        (Skill e) => UserSkill.create(user: cardInfo.user, skill: e)..save()));
    futures.add(Future.forEach(
        cardInfo.interests,
        (Interest e) =>
            UserInterest.create(user: cardInfo.user, interest: e)..save()));
    await Future.wait(futures);
  }

  static Future<CardInfo> get(User user) async {
    return CardInfo(
        user: user,
        education: await Education.getByUser(user),
        work: await Work.getByUser(user),
        volunteering: await Volunteering.getByUser(user),
        skills: await Skill.getByUser(user),
        interests: await Interest.getByUser(user));
  }

  static Future<CardInfo> getById(int id) async {
    User user = await User.get(id);
    return CardInfo(
        user: user,
        education: await Education.getByUser(user),
        work: await Work.getByUser(user),
        volunteering: await Volunteering.getByUser(user),
        skills: await Skill.getByUser(user),
        interests: await Interest.getByUser(user));
  }
}
