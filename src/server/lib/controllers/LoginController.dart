import '../server.dart';
import '../util/auth.dart';

class LoginController extends ResourceController {
  @Operation.post()
  Future<Response> loginUser(@Bind.body() User user) async {
    try {
      final newUser = await User.getByUsername(user.username);
      if (newUser == null) {
        return Response.ok({'success': false});
      }
      final result = await newUser.checkAuth(user.password);
      if (result) {
        final token = generateToken(newUser);
        return Response.ok({'success': true, 'token': token, 'user': newUser.asMap()});
      }
      return Response.ok({'success': false});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to login a user:');
      return Response.serverError(body: {'success': false});
    }
  }
}
