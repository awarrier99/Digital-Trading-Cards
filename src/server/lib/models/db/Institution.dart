import 'package:meta/meta.dart';

import '../../server.dart';

class Institution extends Serializable {
  Institution();

  Institution.create({@required this.name, this.longName});

  String name;
  String longName;

  @override
  Map<String, dynamic> asMap() {
    return {'name': name, 'longName': longName};
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    name = object['name'] as String;
    longName = object['longName'] as String;
  }

  static Future<Institution> get(String name) async {
    try {
      const sql = '''
        SELECT * FROM institutions
        WHERE name = ?
      ''';
      final institution = (await ServerChannel.db.query(sql, [name])).first;
      return Institution.create(
          name: name, longName: institution['long_name'] as String);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get an institution:');
      return null;
    }
  }
}
