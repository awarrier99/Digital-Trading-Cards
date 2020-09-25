import '../server.dart';

class CardController extends ResourceController {
  @Operation.post()
  Future<Response> createCard(@Bind.body() CardInfo cardInfo) async {
    try {
      print(cardInfo.asMap());
      await CardInfo.create(cardInfo);
      return Response.created('/cards/${cardInfo.user.id}',
          body: {'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create a card:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.get('id')
  Future<Response> getCard({@Bind.path('id') int userId}) async {
    try {
      final user = request.attachments['cardUser'] as User;
      return Response.ok(await CardInfo.get(user));
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a card:');
      return Response.serverError(body: {'success': false});
    }
  }
}
