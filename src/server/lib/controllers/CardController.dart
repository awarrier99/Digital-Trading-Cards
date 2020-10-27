import '../server.dart';

class CardController extends ResourceController {
  @Operation.post()
  Future<Response> createCard(@Bind.body() CardInfo cardInfo) async {
    try {
      print(cardInfo.asMap());
      await CardInfo.save(cardInfo);
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
  Future<Response> getCard(@Bind.path('id') int userId) async {
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

  @Operation.get('username')
  Future<Response> getCardByUsername(
      @Bind.path('username') String username) async {
    try {
      return Response.ok(await CardInfo.getByUsername(username));
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get a card:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.put('id')
  Future<Response> updateCard(
      @Bind.body() CardInfoUpdate cardInfoUpdate) async {
    try {
      await CardInfo.update(
          cardInfoUpdate.cardInfo, cardInfoUpdate.deleteLists);
      return Response.ok({'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to update a card:');
      return Response.serverError(body: {'success': false});
    }
  }
}
