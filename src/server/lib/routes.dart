import 'controllers/Authorizer.dart';
import 'controllers/CardController.dart';
import 'controllers/LoginController.dart';
import 'controllers/UserController.dart';
import 'controllers/VerbController.dart';
import 'controllers/SaveCardController.dart';
import 'server.dart';

Controller createRoutes() {
  final router = Router(basePath: '/api');

  router
      .route('/cards[/:id]')
      .link(Authorizer.bearer)
      .link(() => VerbController(Resource.card))
      .link(() => CardController());

  router
      .route('/users[/:id]')
      .link(() => Authorizer.multiple(get: AuthMode.isRequestingUser))
      .link(() => VerbController(Resource.user))
      .link(() => UserController());

  router
      .route('/users/login')
      .link(() => VerbController(Resource.user))
      .link(() => LoginController());

  router
      .route('/cards/saved[/:username]')
      .link(Authorizer.bearer)
      .link(() => VerbController(Resource.user))
      .link(() => SaveCardController());

  return router;
}
