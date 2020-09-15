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
      "user": user.asMap(),
      "interest": interest
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
    interest = Interest()
    ..readFromMap(object['interest'] as Map<String, dynamic>);
  }
}
