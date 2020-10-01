import 'package:server/models/db/Event.dart';

import '../server.dart';

class EventController extends ResourceController {
  @Operation.post()
  Future<Response> createEvent(@Bind.body() Event event) async {
    try {
      final currUser = request.attachments['user'] as User;
      event.owner = currUser;
      await event.save();
      return Response.ok({"success": true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to save a card:');
      return Response.serverError(body: {'success': false});
    }
  }
}
