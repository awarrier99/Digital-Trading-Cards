import '../server.dart';
import '../util/auth.dart';

class LoginController extends ResourceController {
  @Operation.post()
  Future<Response> loginUser(@Bind.body() User user) async {
    try {
      final result = await user.checkAuth();
      if (result) {
        final token = generateToken(user);
        return Response.ok({'success': true, 'token': token});
      }
      return Response.ok({'success': false});
    } catch (err, stackTrace) {
      logError(err, stackTrace: stackTrace, message: 'An error occurred while trying to login a user:');
      return Response.serverError(body: {'success': false});
    }
  }
}
