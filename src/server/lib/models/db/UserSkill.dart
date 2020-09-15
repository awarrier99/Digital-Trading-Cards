import 'package:meta/meta.dart';

import '../../server.dart';
import 'Skill.dart';
import 'User.dart';

class UserSkill extends Serializable {
  UserSkill();

  UserSkill.create({@required this.user, this.skill});

  User user;
  Skill skill;

  @override
  Map<String, dynamic> asMap() {
    return {
      "user": user.asMap(),
      "skill": skill
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
    skill = Skill()
      ..readFromMap(object['skill'] as Map<String, dynamic>);
  }
}
