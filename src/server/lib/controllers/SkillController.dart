import 'package:server/server.dart';
//this is the server controller to get/create new interest. This is a look up table in the database
class SkillController extends ResourceController {
  //api call to get skill if it is already in the database
  @Operation.get('pattern')
  Future<Response> getMatchingSkills(
      @Bind.path('pattern') String pattern) async {
    try {
      final skills = await Skill.find(pattern);
      return Response.ok(
          {'success': true, 'skills': skills.map((e) => e.asMap()).toList()});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get matching skills:');
      return Response.serverError(body: {'success': false});
    }
  }
  //api call to create a new skill if it is not in the table already
  @Operation.post()
  Future<Response> createSkill(@Bind.body() Skill skill) async {
    try {
      await skill.save();
      return Response.ok({'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create a skill:');
      return Response.serverError(body: {'success': false});
    }
  }
}
