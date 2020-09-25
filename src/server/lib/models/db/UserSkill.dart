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
      'user': user.asMap(),
      'skill': skill.asMap()
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    final userMap = object['user'] as Map<String, dynamic>;
    if (stringToUserType(userMap['type'] as String) == UserType.student) {
      user = Student()
        ..readFromMap(userMap);
    } else {
      user = Recruiter()
        ..readFromMap(userMap);
    }
    skill = Skill()
      ..readFromMap(object['skill'] as Map<String, dynamic>);
  }

  Future<void> save() async {
    try {
      const sql = '''
        INSERT INTO user_skills
        (user, skill)
        VALUES (?, ?)
      ''';
      await ServerChannel.db.query(sql, [user.id, skill.title]);
    } catch (err, stackTrace) {
      logError(err, stackTrace: stackTrace, message: 'An error occurred while trying to save a user skill:');
    }
  }
}
