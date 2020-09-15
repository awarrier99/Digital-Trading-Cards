import '../models/rest/CardInfo.dart';
import '../server.dart';

class CardController extends ResourceController {
  @Operation.post()
  Future<Response> createCard(@Bind.body() CardInfo cardInfo) async {
    return Response.ok(cardInfo)
        ..contentType = ContentType.json;
  }
}
