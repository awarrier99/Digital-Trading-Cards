import 'controllers/CardController.dart';
import 'server.dart';

Controller createRoutes() {
  final router = Router(basePath: '/api');

  router
      .route('/cards[/:userId]')
      .link(() => CardController());

  return router;
}
