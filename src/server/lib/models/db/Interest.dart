import 'package:meta/meta.dart';

import '../../server.dart';

// represents an interest
class Interest extends Serializable {
  Interest();

  Interest.create({@required this.title});

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

  // get a list of all interests
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

  // find all interests which match the provided pattern
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
