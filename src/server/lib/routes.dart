import 'controllers/CardController.dart';
import 'controllers/VerbController.dart';
import 'server.dart';

Controller createRoutes() {
  final router = Router(basePath: '/api');

  router
      .route('/cards[/:id]')
      .link(() => VerbController(Resource.card))
      .link(() => CardController());

  return router;
}
