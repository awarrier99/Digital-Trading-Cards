import 'package:meta/meta.dart';

import '../../server.dart';
import 'Interest.dart';
import 'User.dart';

class UserInterest extends Serializable {
  UserInterest();

  UserInterest.create({@required this.user, @required this.interest});

  User user;
  Interest interest;

  @override
  Map<String, dynamic> asMap() {
    return {
      'user': user.asMap(),
      'interest': interest.asMap()
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
    interest = Interest()
    ..readFromMap(object['interest'] as Map<String, dynamic>);
  }

  Future<void> save() async {
    try {
      const sql = '''
        INSERT INTO user_interests
        (user, interest)
        VALUES (?, ?)
      ''';
      await ServerChannel.db.query(sql, [user.id, interest.title]);
    } catch (err, stackTrace) {
      logError(err, stackTrace: stackTrace, message: 'An error occurred while trying to save a user interest:');
    }
  }
}
