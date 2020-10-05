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

  Future<void> save() async {
    try {
      const sql = '''
        INSERT INTO interests
        (title)
        VALUES (?)
      ''';

      await ServerChannel.db.query(sql, [title]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create an interest:');
    }
  }

  static Future<List<Interest>> getAll() async {
    try {
      const sql = '''
        SELECT * FROM interests
      ''';
      final results = await ServerChannel.db.query(sql);
      return results
          .map((e) => Interest.create(title: e['title'] as String))
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get all interests:');
      return [];
    }
  }

  static Future<List<Interest>> find(String pattern) async {
    try {
      if (pattern.isEmpty) {
        return getAll();
      }

      const sql = '''
        SELECT * FROM interests
        WHERE title LIKE ?
      ''';
      final bindPattern = '%$pattern%';
      final results = await ServerChannel.db.query(sql, [bindPattern]);
      return results
          .map((e) => Interest.create(title: e['title'] as String))
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get an interest:');
      return [];
    }
  }
}
