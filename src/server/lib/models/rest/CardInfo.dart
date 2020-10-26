import 'package:meta/meta.dart';

import '../../server.dart';

class CardInfo extends Serializable {
  CardInfo();

  CardInfo.create(
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
  List<UserSkill> skills;
  List<UserInterest> interests;

  @override
  Map<String, dynamic> asMap() {
    return {
      "user": user.asMap(),
      "education": education.map((e) => e.asMap()..remove('user')).toList(),
      "work": work.map((e) => e.asMap()..remove('user')).toList(),
      "volunteering":
          volunteering.map((e) => e.asMap()..remove('user')).toList(),
      "skills": skills.map((e) => e.asMap()..remove('user')).toList(),
      "interests": interests.map((e) => e.asMap()..remove('user')).toList()
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    final userMap = object['user'] as Map<String, dynamic>;
    user = User.fromMap(userMap);
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
        .map((e) => UserSkill()
          ..user = user
          ..readFromMap(e as Map<String, dynamic>))
        .toList();
    final interestsList = object['interests'] as List;
    interests = interestsList
        .map((e) => UserInterest()
          ..user = user
          ..readFromMap(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> _saveAll(CardInfo cardInfo, bool allowUpdate) async {
    final List<Future> futures = [];
    futures.add(Future.forEach(
        cardInfo.education, (Education e) => e.save(allowUpdate: allowUpdate)));
    futures.add(Future.forEach(
        cardInfo.work, (Work e) => e.save(allowUpdate: allowUpdate)));
    futures.add(Future.forEach(cardInfo.volunteering,
        (Volunteering e) => e.save(allowUpdate: allowUpdate)));
    futures.add(Future.forEach(
        cardInfo.skills, (UserSkill e) => e.save(allowUpdate: allowUpdate)));
    futures.add(Future.forEach(cardInfo.interests,
        (UserInterest e) => e.save(allowUpdate: allowUpdate)));
    await Future.wait(futures);
  }

  static Future<void> save(CardInfo cardInfo) {
    return _saveAll(cardInfo, false);
  }

  static Future<CardInfo> get(User user) async {
    return CardInfo.create(
        user: user,
        education: await Education.getByUser(user),
        work: await Work.getByUser(user),
        volunteering: await Volunteering.getByUser(user),
        skills: await UserSkill.getByUser(user),
        interests: await UserInterest.getByUser(user));
  }

  static Future<CardInfo> getById(int id) async {
    final user = await User.get(id);
    return CardInfo.create(
        user: user,
        education: await Education.getByUser(user),
        work: await Work.getByUser(user),
        volunteering: await Volunteering.getByUser(user),
        skills: await UserSkill.getByUser(user),
        interests: await UserInterest.getByUser(user));
  }

  static Future<void> update(
      CardInfo cardInfo, Map<String, List<dynamic>> deleteLists) async {
    await _saveAll(cardInfo, true);
    for (List<dynamic> list in deleteLists.values) {
      for (dynamic e in list) {
        e.delete();
      }
    }
  }
}

class CardInfoUpdate extends Serializable {
  CardInfo cardInfo;
  Map<String, List<dynamic>> deleteLists;

  @override
  Map<String, dynamic> asMap() {
    return {};
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    cardInfo = CardInfo()
      ..readFromMap(object['cardInfo'] as Map<String, dynamic>);
    final temp = object['deleteLists'] as Map<String, dynamic>;
    final tempMap = Map<String, List<dynamic>>.from(temp);
    tempMap.updateAll((key, value) {
      if (key == 'education') {
        return value
            .map((e) => Education()
              ..user = cardInfo.user
              ..readFromMap(e as Map<String, dynamic>))
            .toList();
      }
      if (key == 'work') {
        return value
            .map((e) => Work()
              ..user = cardInfo.user
              ..readFromMap(e as Map<String, dynamic>))
            .toList();
      }
      if (key == 'volunteering') {
        return value
            .map((e) => Volunteering()
              ..user = cardInfo.user
              ..readFromMap(e as Map<String, dynamic>))
            .toList();
      }
      if (key == 'skills') {
        return value
            .map((e) => UserSkill()
              ..user = cardInfo.user
              ..readFromMap(e as Map<String, dynamic>))
            .toList();
      }
      return value
          .map((e) => UserInterest()
            ..user = cardInfo.user
            ..readFromMap(e as Map<String, dynamic>))
          .toList();
    });
    deleteLists = tempMap;
  }
}
