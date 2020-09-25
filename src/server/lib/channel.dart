import 'routes.dart';
import 'server.dart';
import 'util/db.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class ServerChannel extends ApplicationChannel {
  static Database db;
  static ServerConfig config;

  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    config = ServerConfig(options.configurationFilePath);
    db = Database(config);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint => createRoutes();
}

class JwtConfig extends Configuration {
  String key;
  String aud;
  String iss;
}

class ServerConfig extends Configuration {
  ServerConfig(String path): super.fromFile(File(path));

  DatabaseConfiguration database;
  JwtConfig jwt;
}
