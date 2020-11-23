import 'package:meta/meta.dart';

import '../../server.dart';

// Represents a company
class Company extends Serializable {
  Company();

  Company.create({@required this.name});

  String name;

  // serializes a class instance into a JSON response payload
  @override
  Map<String, dynamic> asMap() {
    return {'name': name};
  }

  // serializes the JSON request payload into a class instance
  @override
  void readFromMap(Map<String, dynamic> object) {
    name = object['name'] as String;
  }

  // save a class instance in the database
  Future<void> save() async {
    try {
      const sql = '''
        INSERT INTO companies
        (name)
        VALUES (?)
      ''';

      await ServerChannel.db.query(sql, [name]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create a company:');
    }
  }

  // get a list of all companies in the database
  static Future<List<Company>> getAll() async {
    try {
      const sql = '''
        SELECT * FROM companies
      ''';
      final results = await ServerChannel.db.query(sql);
      return results
          .map((e) => Company.create(name: e['name'] as String))
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get all companies:');
      return [];
    }
  }

  // find companies matching the provided pattern
  static Future<List<Company>> find(String pattern) async {
    try {
      if (pattern.isEmpty) {
        return getAll();
      }

      const sql = '''
        SELECT * FROM companies
        WHERE name LIKE ?
      ''';
      final bindPattern = '%$pattern%';
      final results = await ServerChannel.db.query(sql, [bindPattern]);
      return results
          .map((e) => Company.create(name: e['name'] as String))
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a company:');
      return [];
    }
  }
}
