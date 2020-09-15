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
    return {
      "user1": user1.asMap(),
      "user2": user2.asMap()
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    final user1Map = object['user1'] as Map<String, dynamic>;
    final user2Map = object['user2'] as Map<String, dynamic>;

    if (user1Map['type'] == UserType.student.toString()) {
      user1 = Student()
        ..readFromMap(user1Map);
    } else {
      user1 = Recruiter()
        ..readFromMap(user1Map);
    }
    if (user2Map['type'] == UserType.student) {
      user2 = Student()
        ..readFromMap(user2Map);
    } else {
      user2 = Recruiter()
        ..readFromMap(user2Map);
    }
  }
}
