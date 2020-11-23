import '../server.dart';

//this is the controller to handle a user's digital trading card. 
class CardController extends ResourceController {
  //creating a digital trading caard
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

  //getting the logged in user's card
  @Operation.get('id')
  Future<Response> getCard() async {
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

  // @Operation.get('username')
  // Future<Response> getCardByUsername(
  //     @Bind.path('username') String username) async {
  //   try {
  //     final user = request.attachments['cardUser'] as User;
  //     return Response.ok(await CardInfo.get(user));
  //   } catch (err, stackTrace) {
  //     logError(err,
  //         stackTrace: stackTrace,
  //         message: 'An error occurred while trying to get a card:');
  //     return Response.serverError(body: {'success': false});
  //   }
  // }

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
