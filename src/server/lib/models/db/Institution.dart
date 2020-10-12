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
