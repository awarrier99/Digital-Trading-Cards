import '../server.dart';
import '../util/auth.dart';

class SaveCardController extends ResourceController {
  @Operation.post('username')
  Future<Response> saveCard(@Bind.path('username') String username) async {
    try {
      final newUser = await User.getByUsername(username);
      final user = request.attachments['user'] as User;
      await User.saveConnections(user.id, newUser.id);
      return Response.ok({"success": "true"});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to save a card:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.post()
  Future<Response> createConnection(@Bind.body() ConnectionInfo connectionInfo) async {
    try {
      await ConnectionInfo.create(connectionInfo);
      return Response.created('/connections/${connectionInfo.user.id}',
          body: {'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create the user connection:');
      return Response.serverError(body: {'success': false});
    }
  }
  @Operation.get('id')
  Future<Response> getConnection({@Bind.path('id') int userId}) async {
    try {

      final user = request.attachments['connectionUser'] as User; // only support getting the current user
      return Response.ok(await ConnectionInfo.get(user));
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a connections:');
      return Response.serverError(body: {'success': false});
    }
  }
}

