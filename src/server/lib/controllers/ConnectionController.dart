import '../server.dart';

class ConnectionController extends ResourceController {
  @Operation.post()
  Future<Response> requestConnection(@Bind.body() User user) async {
    try {
      final newUser = await User.getByUsername(user.username);
      final currUser = request.attachments['user'] as User;
      await user.saveConnections(currUser.id, newUser.id);
      return Response.created('/connections/${currUser.id}', body: {'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to save a card:');
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
          message: 'An error occurred while trying to get a connection:');
      return Response.serverError(body: {'success': false});
    }
  }
}

