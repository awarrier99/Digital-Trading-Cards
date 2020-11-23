import 'package:meta/meta.dart';

import '../../server.dart';

// represents an institution or school
class Institution extends Serializable {
  Institution();

  Institution.create({@required this.name, this.longName});

  String name;
  String longName;

  // serializes a class instance into a JSON response payload
  @override
  Map<String, dynamic> asMap() {
    return {'name': name, 'longName': longName};
  }

  // serializes the JSON request payload into a class instance
  @override
  void readFromMap(Map<String, dynamic> object) {
    name = object['name'] as String;
    longName = object['longName'] as String;
  }

  // saves a class instance in the database
  Future<void> save() async {
    try {
      const sql = '''
        INSERT INTO institutions
        (name, long_name)
        VALUES (?, ?)
      ''';
      await ServerChannel.db.query(sql, [name, longName]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create an institution:');
    }
  }

  // get an institution by name
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

  // get a list of all institutions
  static Future<List<Institution>> getAll() async {
    try {
      const sql = '''
          SELECT * FROM institutions
        ''';
      final results = await ServerChannel.db.query(sql);
      return results
          .map((e) => Institution.create(
          name: e['name'] as String, longName: e['long_name'] as String))
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get all institutions:');
      return [];
    }
  }

  // find all institutions which match the provided pattern
  static Future<List<Institution>> find(String pattern) async {
    try {
      if (pattern.isEmpty) {
        return getAll();
      }

      const sql = '''
        SELECT * FROM institutions
        WHERE LOWER(name) LIKE ?
          OR LOWER(long_name) LIKE ?
      ''';
      final bindPattern = '%$pattern%'.toLowerCase();
      final results =
          await ServerChannel.db.query(sql, [bindPattern, bindPattern]);
      return results
          .map((e) => Institution.create(
              name: e['name'] as String, longName: e['long_name'] as String))
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get an institution:');
      return [];
    }
  }
}
