import 'package:meta/meta.dart';

import '../../server.dart';
import 'Interest.dart';
import 'User.dart';

class UserInterest extends Serializable {
  UserInterest();

  UserInterest.create({@required this.user, @required this.interest});

  int id;
  User user;
  Interest interest;

  @override
  Map<String, dynamic> asMap() {
    return {'id': id, 'user': user.asMap(), 'interest': interest.asMap()};
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'] as int;
    if (user == null) {
      final userMap = object['user'] as Map<String, dynamic>;
      user = User.fromMap(userMap);
    }
    interest = Interest()
      ..readFromMap(object['interest'] as Map<String, dynamic>);
  }

  Future<void> save({bool allowUpdate = true}) async {
    try {
      String sql;
      final values = [user.id, interest.title];
      if (id == null) {
        sql = '''
          INSERT INTO user_interests
          (user, interest)
          VALUES (?, ?)
        ''';
      } else if (allowUpdate) {
        sql = '''
          UPDATE user_interests
          SET interest = ?
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
          message: 'An error occurred while trying to save a user interest:');
    }
  }

  Future<void> delete() async {
    try {
      if (id == null) {
        print('Unsaved user interests cannot be deleted');
        return;
      }

      const sql = '''
        DELETE FROM user_interests
        WHERE id = ?
      ''';

      await ServerChannel.db.query(sql, [id]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to delete a user interest:');
    }
  }

  static Future<List<UserInterest>> getByUser(User user) async {
    try {
      const sql = '''
        SELECT * FROM user_interests
        WHERE user = ?
      ''';
      final results = await ServerChannel.db.query(sql, [user.id]);

      return results
          .map((e) => UserInterest.create(
              user: user,
              interest: Interest.create(title: e['interest'] as String))
            ..id = e['id'] as int)
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get user interests:');
      return [];
    }
  }
}
