import '../models/db/models.dart';
import '../models/rest/CardInfo.dart';
import '../server.dart';

class CardController extends ResourceController {
  @Operation.post()
  Future<Response> createCard(@Bind.body() CardInfo cardInfo) async {
    try {
      final List<Future> futures = [];
      await cardInfo.user.save();
      futures.add(
          Future.forEach(cardInfo.education, (Education e) => e.save())
      );
      futures.add(
          Future.forEach(cardInfo.work, (Work e) => e.save())
      );
      futures.add(
          Future.forEach(cardInfo.volunteering, (Volunteering e) => e.save())
      );
      futures.add(
          Future.forEach(
              cardInfo.skills,
                (Skill e) => UserSkill.create(user: cardInfo.user, skill: e)
                  ..save()
          )
      );
      futures.add(
          Future.forEach(
              cardInfo.interests,
                  (Interest e) => UserInterest.create(user: cardInfo.user, interest: e)
                ..save()
          )
      );
      await Future.wait(futures);
      return Response.created('/cards/${cardInfo.user.id}', body: {'success': true});
    } catch (err, stackTrace) {
      print('An error occurred while trying to create a card:');
      print(err);
      print(stackTrace);
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.get('id')
  Future<Response> getCard({@Bind.path('id') int userId}) async {
    try {
      final user = await User.get(userId);
      if (user == null) {
        return Response.notFound(body: {'success': false});
      }

      return Response.ok(await CardInfo.get(user))
          ..contentType = ContentType.json;
    } catch (err, stackTrace) {
      print('An error occurred while trying to get a card:');
      print(err);
      print(stackTrace);
      return Response.serverError(body: {'success': false});
    }
  }
}
