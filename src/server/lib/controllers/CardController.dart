import '../models/db/models.dart';
import '../models/rest/CardInfo.dart';
import '../server.dart';

class CardController extends ResourceController {
  @Operation.post()
  Future<Response> createCard(@Bind.body() CardInfo cardInfo) async {
    try {
      await CardInfo.create(cardInfo);
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
