import 'package:meta/meta.dart';

import '../../server.dart';
import 'Skill.dart';
import 'User.dart';

// represents a many-to-many relationship between users and skills
class UserSkill extends Serializable {
  UserSkill();

  UserSkill.create({@required this.user, this.skill});

  int id;
  User user;
  Skill skill;

  // serializes a class instance into a JSON response payload
  @override
  Map<String, dynamic> asMap() {
    return {'id': id, 'user': user.asMap(), 'skill': skill.asMap()};
  }

  // serializes the JSON request payload into a class instance
  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'] as int;
    if (user == null) {
      final userMap = object['user'] as Map<String, dynamic>;
      user = User.fromMap(userMap);
    }
    skill = Skill()..readFromMap(object['skill'] as Map<String, dynamic>);
  }

  // save or update a class instance in the database
  Future<void> save({bool allowUpdate = true}) async {
    try {
      String sql;
      final values = [user.id, skill.title];
      if (id == null) {
        sql = '''
          INSERT INTO user_skills
          (user, skill)
          VALUES (?, ?)
        ''';
      } else if (allowUpdate) {
        sql = '''
          UPDATE user_skills
          SET skill = ?
          WHERE id = ?
        ''';
        values.removeAt(0);
        values.add(id);
      } else {
        return;
      }

      final results = await ServerChannel.db.query(sql, values);
      id ??= results.insertId;
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to save a user skill:');
    }
  }

  // delete a class instance in the database
  Future<void> delete() async {
    try {
      if (id == null) {
        print('Unsaved user skills cannot be deleted');
        return;
      }

      const sql = '''
        DELETE FROM user_skills
        WHERE id = ?
      ''';

      await ServerChannel.db.query(sql, [id]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to delete a user skill:');
    }
  }

  // get a list of a user's skills
  static Future<List<UserSkill>> getByUser(User user) async {
    try {
      const sql = '''
        SELECT * FROM user_skills
        WHERE user = ?
      ''';
      final results = await ServerChannel.db.query(sql, [user.id]);

      return results
          .map((e) => UserSkill.create(
              user: user, skill: Skill.create(title: e['skill'] as String))
            ..id = e['id'] as int)
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get user skills:');
      return [];
    }
  }
}
