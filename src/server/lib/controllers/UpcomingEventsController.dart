import 'package:server/models/db/Event.dart';

import '../server.dart';
//this is the server controller to get the upcoming events for a user based on a user's id
class UpcomingEventsController extends ResourceController {
  @Operation.get('userId')
  Future<Response> getUpcomingEvents(@Bind.path('userId') int userId) async {
    try {
      return Response.ok(await Event.getUpcoming(userId));
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message:
              'An error occurred while trying to get the upcoming events:');
      return Response.serverError(body: {'success': false});
    }
  }
}
