import 'package:meta/meta.dart';

import '../../server.dart';

class Skill extends Serializable {
  Skill();

  Skill.create({@required this.title});

  String title;

  @override
  Map<String, dynamic> asMap() {
    return {'title': title};
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    title = object['title'] as String;
  }

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
