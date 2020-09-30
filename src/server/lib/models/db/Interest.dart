import 'package:meta/meta.dart';

import '../../server.dart';

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
}
