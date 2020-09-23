import '../models/db/models.dart';
import '../server.dart';

class LoginController extends ResourceController {
  @Operation.post()
  Future<Response> loginUser(@Bind.body() User user) async {
    try {
      final result = await user.checkAuth(user.username, user.password);
      if (result == true) {
        return Response.ok("Authenticated")..contentType = ContentType.text;
      }
      return Response.ok("Username or password incorrect")
        ..contentType = ContentType.text;
    } catch (err, stackTrace) {
      print('An error occurred while trying login:');
      print(err);
      print(stackTrace);
      return Response.serverError(body: {'success': false});
    }
  }
}
