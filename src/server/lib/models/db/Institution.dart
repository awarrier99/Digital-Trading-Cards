import 'package:meta/meta.dart';

import '../../server.dart';

class Institution extends Serializable {
  Institution();

  Institution.create({@required this.name, this.longName});

  String name;
  String longName;

  @override
  Map<String, dynamic> asMap() {
    return{
      'name': name,
      'longName': longName
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    name = object['name'] as String;
    longName = object['longName'] as String;
  }

  static Future<Institution> get(String name) async {
    const sql = '''
      SELECT * FROM institutions
      WHERE name = ?
    ''';
    final institution = (await ServerChannel.db.query(sql, [name])).first;
    return Institution.create(name: name, longName: institution[1] as String);
  }
}
