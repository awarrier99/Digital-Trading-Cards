import 'package:meta/meta.dart';

import '../../server.dart';

// represents a skill
class Skill extends Serializable {
  Skill();

  Skill.create({@required this.title});

  String title;

  // serializes a class instance into a JSON response payload
  @override
  Map<String, dynamic> asMap() {
    return {'title': title};
  }

  // serializes the JSON request payload into a class instance
  @override
  void readFromMap(Map<String, dynamic> object) {
    title = object['title'] as String;
  }

  // saves a class instance in the database
  Future<void> save() async {
    try {
      const sql = '''
        INSERT INTO skills
        (title)
        VALUES (?)
      ''';

      await ServerChannel.db.query(sql, [title]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create a skill:');
    }
  }

  // get a list of all skills
  static Future<List<Skill>> getAll() async {
    try {
      const sql = '''
        SELECT * FROM skills
      ''';
      final results = await ServerChannel.db.query(sql);
      return results
          .map((e) => Skill.create(title: e['title'] as String))
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get all skills:');
      return [];
    }
  }

  // find all skills which match the provided pattern
  static Future<List<Skill>> find(String pattern) async {
    try {
      if (pattern.isEmpty) {
        return getAll();
      }

      const sql = '''
        SELECT * FROM skills
        WHERE title LIKE ?
      ''';
      final bindPattern = '%$pattern%';
      final results = await ServerChannel.db.query(sql, [bindPattern]);
      return results
          .map((e) => Skill.create(title: e['title'] as String))
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a skill:');
      return [];
    }
  }
}
