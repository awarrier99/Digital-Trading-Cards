import '../server.dart';

// connect to the mysql database
class Database {
  factory Database(ServerConfig config) {
    _database.config = config;
    return _database;
  }

  Database._create();

  static final Database _database = Database._create();
  ServerConfig config;
  static MySqlConnection conn;

  Future<MySqlConnection> _connect() async {
    final settings = ConnectionSettings(
        host: config.database.host,
        port: config.database.port,
        user: config.database.username,
        password: config.database.password,
        db: config.database.databaseName);
    return MySqlConnection.connect(settings);
  }

  // helper for querying the database
  Future<Results> query(String sql, [List<dynamic> values]) async {
    conn ??= await _connect();
    return conn.query(sql, values);
  }
}
