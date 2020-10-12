import 'package:server/server.dart';

class SkillController extends ResourceController {
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
