import 'package:server/controllers/CompanyController.dart';
import 'package:server/controllers/FieldController.dart';
import 'package:server/controllers/InstitutionController.dart';
import 'package:server/controllers/InterestController.dart';
import 'package:server/controllers/SkillController.dart';

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
      .link(() => Authorizer.multiple(
          get: AuthMode.bearer,
          post: AuthMode.bearer,
          put: AuthMode.isRequestingUser))
      .link(() => VerbController(Resource.card))
      .link(() => CardController());

  router
      .route('/allCards[/:username]')
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
      .route('/cards/saved[/:id]')
      .link(Authorizer.bearer)
      .link(() => VerbController(Resource.user))
      .link(() => SaveCardController());

  router
      .route('/institutions[/:pattern]')
      .link(Authorizer.bearer)
      .link(() => VerbController(Resource.institution))
      .link(() => InstitutionController());

  router
      .route('/fields[/:pattern]')
      .link(Authorizer.bearer)
      .link(() => VerbController(Resource.field))
      .link(() => FieldController());

  router
      .route('/skills[/:pattern]')
      .link(Authorizer.bearer)
      .link(() => VerbController(Resource.skill))
      .link(() => SkillController());

  router
      .route('/interests[/:pattern]')
      .link(Authorizer.bearer)
      .link(() => VerbController(Resource.interest))
      .link(() => InterestController());

  router
      .route('/companies[/:pattern]')
      .link(Authorizer.bearer)
      .link(() => VerbController(Resource.company))
      .link(() => CompanyController());

  return router;
}
