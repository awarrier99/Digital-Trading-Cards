import '../server.dart';

class ConnectionController extends ResourceController {
  @Operation.post()
  Future<Response> requestConnection(@Bind.body() User user) async {
    try {
      final recipient = await User.getByUsername(user.username);
      final currUser = request.attachments['user'] as User;
      final connection =
          Connection.create(sender: currUser, recipient: recipient);
      final doesNotExist = await connection.save();
      if (!doesNotExist) {
        return Response.ok({'success': false});
      }
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

  @Operation.delete('id')
  Future<Response> rejectConnection(@Bind.path('id') int id) async {
    try {
      final connection = request.attachments['connection'] as Connection;
      await connection.delete();
      return Response.ok({'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to delete a connection:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.get('id')
  Future<Response> getConnectionInfo(
      {@Bind.query('onlyPending') String onlyPending = 'false',
      @Bind.query('incoming') String incoming = 'true'}) async {
    try {
      final user = request.attachments['connectionUser'] as User; // only support getting the current user
      return Response.ok(await ConnectionInfo.getByUser(user,
          onlyPending: onlyPending != 'false', incoming: incoming != 'false'));
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a connection:');
      return Response.serverError(body: {'success': false});
    }
  }
}
