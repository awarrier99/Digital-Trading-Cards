import 'package:meta/meta.dart';

import '../../server.dart';
import 'User.dart';

class Connection extends Serializable {
  Connection();

  Connection.create({@required this.user1, @required this.user2});

  User user1;
  User user2;

  @override
  Map<String, dynamic> asMap() {
    print(user1.asMap());
    return {'user1': user1.asMap(), 'user2': user2.asMap()};
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    final user1Map = object['user1'] as Map<String, dynamic>;
    final user2Map = object['user2'] as Map<String, dynamic>;

    if (stringToUserType(user1Map['type'] as String) == UserType.student) {
      user1 = Student()..readFromMap(user1Map);
    } else {
      user1 = Recruiter()..readFromMap(user1Map);
    }
    if (stringToUserType(user2Map['type'] as String) == UserType.student) {
      user2 = Student()..readFromMap(user2Map);
    } else {
      user2 = Recruiter()..readFromMap(user2Map);
    }
  }

  Future<void> save() async {
    const sql = '''
      INSERT INTO connections
      (user1_id, user2_id)
      VALUES (?, ?)
    ''';
    await ServerChannel.db.query(sql, [user1.id, user2.id]);
  }

  // This method gets the user in the connection that is not the one specified
  // with the user parameter
  static Future<List<CardInfo>> getOtherUsers(User user) async {
    try {
      const sql1 = '''
        SELECT user2_id as otherUserId
        FROM connections
        WHERE user1_id = ?
      ''';

      const sql2 = '''
        SELECT user1_id as otherUserId
        FROM connections
        WHERE user2_id = ?
      ''';
      final results1 = await ServerChannel.db.query(sql1, [user.id]);
      final results2 = await ServerChannel.db.query(sql2, [user.id]);

      print("$results1");
      final resultsList1 = results1
          .map((e) async => CardInfo.getById(e['otherUserId'] as int))
          .toList();

      final resultsList2 = results2
          .map((e) async => CardInfo.getById(e['otherUserId'] as int))
          .toList();

      return Future.wait(List.from(resultsList1)..addAll(resultsList2));
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message:
              'An error occurred while trying to get the connected users:');
      return [];
    }
  }

  static Future<List<Connection>> getByUser(User user) async {
    try {
      const sql1 = '''
        SELECT *
        FROM connections
        WHERE user1_id = ?
      ''';

      const sql2 = '''
        SELECT *
        FROM connections
        WHERE user2_id = ?
      ''';

      final results1 = await ServerChannel.db.query(sql1, [user.id]);
      final results2 = await ServerChannel.db.query(sql2, [user.id]);

      final resultsList1 = results1
          .map((e) async => Connection.create(
                user1: await User.get(e['user1_id'] as int),
                user2: await User.get(e['user2_id'] as int),
              ))
          .toList();

      final resultsList2 = results2
          .map((e) async => Connection.create(
                user1: await User.get(e['user1_id'] as int),
                user2: await User.get(e['user2_id'] as int),
              ))
          .toList();

      return Future.wait(List.from(resultsList1)..addAll(resultsList2));
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get user connections:');
      return [];
    }
  }
}
