import '../server.dart';

class ConnectionController extends ResourceController {
  @Operation.post()
  Future<Response> requestConnection(@Bind.body() User user) async {
    try {
      final recipient = await User.getByUsername(user.username);
      final currUser = request.attachments['user'] as User;
      final connection =
          Connection.create(sender: currUser, recipient: recipient);
      await connection.save();
      return Response.created('/connections/${currUser.id}',
          body: {'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to save a card:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.put('id')
  Future<Response> acceptConnection(@Bind.body() Connection connection) async {
    try {
      connection.pending = false;
      await connection.save();
      return Response.ok({'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to update a connection:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.get('id')
  Future<Response> getConnectionInfo(
      {@Bind.query('getCards') bool getCards = false}) async {
    try {
      final user = request.attachments['connectionUser']
          as User; // only support getting the current user
      return Response.ok(
          await ConnectionInfo.getByUser(user, getCards: getCards));
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a connection:');
      return Response.serverError(body: {'success': false});
    }
  }
}
