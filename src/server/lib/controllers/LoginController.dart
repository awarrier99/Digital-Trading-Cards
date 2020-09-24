import '../models/db/models.dart';
import '../server.dart';

class LoginController extends ResourceController {
  @Operation.post()
  Future<Response> loginUser(@Bind.body() User user) async {
    try {
      final result = await user.checkAuth();
      if (result == true) {
        return Response.ok({"success": true});
      }
      print(result);
      return Response.ok({"success": false});
    } catch (err, stackTrace) {
      print('An error occurred while trying login:');
      print(err);
      print(stackTrace);
      return Response.serverError(body: {'success': false});
    }
  }
}
