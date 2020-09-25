import 'package:meta/meta.dart';

import '../../server.dart';
import 'User.dart';

class Interest extends Serializable {
  Interest();

  Interest.create({@required this.title});

  String title;

  @override
  Map<String, dynamic> asMap() {
    return {'title': title};
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    title = object['title'] as String;
  }

  static Future<List<Interest>> getByUser(User user) async {
    try {
      const sql = '''
        SELECT * FROM user_interests
        WHERE user = ?
      ''';
      final results = await ServerChannel.db.query(sql, [user.id]);

      return results
          .map((e) => Interest.create(title: e['title'] as String))
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get user interests:');
      return [];
    }
  }
}
