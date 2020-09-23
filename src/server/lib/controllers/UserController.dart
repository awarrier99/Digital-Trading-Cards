import '../models/db/models.dart';
import '../server.dart';

class UserController extends ResourceController {
  @Operation.post()
  Future<Response> createUser(@Bind.body() User user) async {
    print('create');
    try {
      User newUser;
      if (user.type == UserType.student) {
        newUser = Student.of(user);
      } else {
        newUser = Recruiter.of(user);
      }
      await newUser.save();
      return Response.created('/users/${user.id}', body: {'success': true});
    } catch (err, stackTrace) {
      print('An error occurred while trying to create a user:');
      print(err);
      print(stackTrace);
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.get('id')
  Future<Response> getUser({@Bind.path('id') int userId}) async {
    try {
      final user = await User.get(userId);
      if (user == null) {
        return Response.notFound(body: {'success': false});
      }

      return Response.ok(user)..contentType = ContentType.json;
    } catch (err, stackTrace) {
      print('An error occurred while trying to get a user:');
      print(err);
      print(stackTrace);
      return Response.serverError(body: {'success': false});
    }
  }
}
