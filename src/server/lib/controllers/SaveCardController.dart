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
}
