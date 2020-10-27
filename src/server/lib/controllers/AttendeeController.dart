import 'package:server/models/db/Event.dart';

import '../server.dart';

class AttendeeController extends  ResourceController {
  @Operation.post()
  Future<Response> addAttendee(
      @Bind.body() Event event) async {
    try {
      final currUser = request.attachments['user'] as User;
      event.owner = currUser;
      await event.addAttendee();
      return Response.ok({"success": true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to add an attendee:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.get('id')
  Future<Response> getAttendees(@Bind.path('id') int eventId) async {
    try {
      return Response.ok(await Event.getAttendees(eventId));
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a event:');
      return Response.serverError(body: {'success': false});
    }
  }


}