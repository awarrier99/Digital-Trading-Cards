import 'controllers/CardController.dart';
import 'controllers/UserController.dart';
import 'controllers/VerbController.dart';
import 'controllers/LoginController.dart';
import 'server.dart';

Controller createRoutes() {
  final router = Router(basePath: '/api');

  router
      .route('/cards[/:id]')
      .link(() => VerbController(Resource.card))
      .link(() => CardController());

  router
      .route('/users[/:id]')
      .link(() => VerbController(Resource.user))
      .link(() => UserController());

  router
      .route('/users/login')
      .link(() => VerbController(Resource.user))
      .link(() => LoginController());

  return router;
}
