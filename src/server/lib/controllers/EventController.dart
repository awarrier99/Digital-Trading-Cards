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
          message: 'An error occurred while trying to save a event:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.get('id')
  Future<Response> getEvent(@Bind.path('id') int eventId) async {
    try {
      return Response.ok(await Event.get(eventId));
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a event:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.put('id')
  Future<Response> updateEvent(
      @Bind.body() Event event, @Bind.path('id') int eventId) async {
    try {
      final currUser = request.attachments['user'] as User;
      event.owner = currUser;
      event.id = eventId;
      print(event);
      await event.updateEvent();
      return Response.ok({'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to update an event:');
      return Response.serverError(body: {'success': false});
    }
  }
}
