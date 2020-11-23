import 'package:server/controllers/AttendeeController.dart';
import 'package:server/controllers/CompanyController.dart';
import 'package:server/controllers/FieldController.dart';
import 'package:server/controllers/InstitutionController.dart';
import 'package:server/controllers/InterestController.dart';
import 'package:server/controllers/MessageController.dart';
import 'package:server/controllers/SkillController.dart';
import 'package:server/controllers/UpcomingEventsController.dart';

import 'controllers/Authorizer.dart';
import 'controllers/CardController.dart';
import 'controllers/ConnectionController.dart';
import 'controllers/EventController.dart';
import 'controllers/LoginController.dart';
import 'controllers/UserController.dart';
import 'controllers/VerbController.dart';
import 'server.dart';

// define all API endpoints
Controller createRoutes() {
  final router = Router(basePath: '/api');
  final connections = {};

  router
      .route('/cards[/:id]')
      .link(() => Authorizer.multiple(
          get: AuthMode.bearer,
          post: AuthMode.bearer,
          put: AuthMode.isRequestingUser))
      .link(() => VerbController(Resource.card))
      .link(() => CardController());

  // router
  //     .route('/cards/username/:username')
  //     .link(Authorizer.bearer)
  //     .link(() => VerbController(Resource.card))
  //     .link(() => CardController());

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
      .route('/connections[/:id]')
      .link(Authorizer.bearer)
      .link(() => VerbController(Resource.connection))
      .link(() => ConnectionController());

  router
      .route('/events[/:id]')
      .link(Authorizer.bearer)
      .link(() => VerbController(Resource.event))
      .link(() => EventController());

  router.route('/allEvents[/:userId]').link(() => UpcomingEventsController());

  router
      .route('/events/attendees[/:id]')
      .link(Authorizer.bearer)
      .link(() => VerbController(Resource.user))
      .link(() => VerbController(Resource.event))
      .link(() => AttendeeController());

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

  router
      .route('/messaging[/:senderId[/:receiverId]]')
      .link(Authorizer.bearer)
      .link(() => VerbController(Resource.messages))
      .link(() => MessageController());
  return router;
}
