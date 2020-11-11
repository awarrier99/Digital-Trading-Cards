import 'package:server/server.dart';

//this is the server controller to get/create new interest. This is a look up table in the database
class InterestController extends ResourceController {
    //api call to get interest if it is already in the database
  @Operation.get('pattern')
  Future<Response> getMatchingInterests(
      @Bind.path('pattern') String pattern) async {
    try {
      final interests = await Interest.find(pattern);
      return Response.ok({
        'success': true,
        'interests': interests.map((e) => e.asMap()).toList()
      });
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get matching interests:');
      return Response.serverError(body: {'success': false});
    }
  }
  //api call to create a new interest if it is not in the table already
  @Operation.post()
  Future<Response> createInterest(@Bind.body() Interest interest) async {
    try {
      await interest.save();
      return Response.ok({'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create an interest:');
      return Response.serverError(body: {'success': false});
    }
  }
}
