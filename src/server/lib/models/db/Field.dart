import 'package:meta/meta.dart';

import '../../server.dart';

// represents a field of study
class Field extends Serializable {
  Field();

  Field.create({@required this.abbreviation, @required this.name});

  String abbreviation;
  String name;

  // serializes a class instance into a JSON response payload
  @override
  Map<String, dynamic> asMap() {
    return {'abbreviation': abbreviation, 'name': name};
  }

  // serializes the JSON request payload into a class instance
  @override
  void readFromMap(Map<String, dynamic> object) {
    abbreviation = object['abbreviation'] as String;
    name = object['name'] as String;
  }

  // saves a class instance in the database
  Future<void> save() async {
    try {
      const sql = '''
        INSERT INTO fields
        (abbreviation, name)
        VALUES (?, ?)
      ''';
      await ServerChannel.db.query(sql, [abbreviation, name]);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create a field:');
    }
  }

  // get all fields in the database
  static Future<List<Field>> getAll() async {
    try {
      const sql = '''
          SELECT * FROM fields
        ''';
      final results = await ServerChannel.db.query(sql);
      return results
          .map((e) => Field.create(
          abbreviation: e['abbreviation'] as String,
          name: e['name'] as String))
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get all fields:');
      return [];
    }
  }

  // find all fields that match the provided pattern
  static Future<List<Field>> find(String pattern) async {
    try {
      if (pattern.isEmpty) {
        return getAll();
      }

      const sql = '''
        SELECT * FROM fields
        WHERE name LIKE ?
      ''';
      final bindPattern = '%$pattern%';
      final results = await ServerChannel.db.query(sql, [bindPattern]);
      return results
          .map((e) => Field.create(
              abbreviation: e['abbreviation'] as String,
              name: e['name'] as String))
          .toList();
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a field:');
      return [];
    }
  }
}
