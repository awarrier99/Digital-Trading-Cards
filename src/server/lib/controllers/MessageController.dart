import 'package:server/models/db/Message.dart';

import '../server.dart';

//this is the controller to create connections between users.
class MessageController extends ResourceController {
  //the api call for a user to make a connection with another user
  @Operation.post()
  Future<Response> sendMessage(@Bind.body() Message message) async {
    try {
      await message.save();
      return Response.ok({'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create a message:');
      return Response.serverError(body: {'success': false});
    }
  }

  //api call to get the connections of the user logged in
  @Operation.get('senderId', 'receiverId')
  Future<Response> getMessages(@Bind.path('senderId') int senderId,
      @Bind.path('receiverId') int receiverId) async {
    try {
      final sender = request.attachments['sender']
          as User; // only support getting the current user
      return Response.ok(await Message.getMessages(senderId, receiverId));
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get messages:');
      return Response.serverError(body: {'success': false});
    }
  }
}
