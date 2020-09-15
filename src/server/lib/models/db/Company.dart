import 'package:meta/meta.dart';

import '../../server.dart';

class Company extends Serializable {
  Company();

  Company.create({@required this.name});

  String name;

  @override
  Map<String, dynamic> asMap() {
    return {
      "name": name
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    name = object['name'] as String;
  }
}
