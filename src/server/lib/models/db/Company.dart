import 'package:meta/meta.dart';

import '../../server.dart';

class Company extends Serializable {
  Company();

  Company.create({@required this.name});

  String name;

  @override
  Map<String, dynamic> asMap() {
    return {'name': name};
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    name = object['name'] as String;
  }

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
