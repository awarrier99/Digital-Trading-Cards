import 'package:server/models/db/Event.dart';

import '../server.dart';

//this is the controller to handle events
class EventController extends ResourceController {
  //api call to create an event
  @Operation.post()
  Future<Response> createEvent(@Bind.body() Event event) async {
    try {
      final currUser = request.attachments['user'] as User;
      event.owner = currUser;
      await event.save();
      return Response.created('/event/${event.id}',
          body: {'success': true});
      // return Response.ok({"success": true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to save a event:');
      return Response.serverError(body: {'success': false});
    }
  }

  //api call to get an event by searching using an event's id
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
  //api call to update the details of an event
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
    }
  }
  //api call to get the upcoming events that a user has registered for
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
