import '../server.dart';
import '../util/auth.dart';

//this is the server controller to register a new user and get the current user logged in 
class UserController extends ResourceController {
  @Operation.post()
  Future<Response> createUser(@Bind.body() User user) async {
    try {
      User newUser;
      if (user.type == UserType.student) {
        newUser = Student.of(user);
      } else {
        newUser = Recruiter.of(user);
      }
      await newUser.save();

      final token = generateToken(newUser);
      return Response.created('/users/${user.id}',
          body: {'success': true, 'id': newUser.id, 'token': token});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create a user:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.get('id')
  Future<Response> getUser() async {
    try {
      final user = request.attachments['user']
          as User; // only support getting the current user
      return Response.ok(user);
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a user:');
      return Response.serverError(body: {'success': false});
    }
  }
}
