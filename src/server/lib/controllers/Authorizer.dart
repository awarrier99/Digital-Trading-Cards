import '../server.dart';
import '../util/auth.dart';
import 'VerbController.dart';

enum AuthMode { none, bearer, isRequestingUser }

class Authorizer {
  static final Map<Verb, AuthMode> verbMapTemplate = {
    Verb.post: null,
    Verb.get: null,
    Verb.put: null,
    Verb.patch: null,
    Verb.delete: null
  };

  static _AuthController bearer() {
    final verbMap = Map.of(verbMapTemplate)
      ..updateAll((key, value) => AuthMode.bearer);
    return _AuthController(verbMap);
  }

  static _AuthController isRequestingUser() {
    final verbMap = Map.of(verbMapTemplate)
      ..updateAll((key, value) => AuthMode.isRequestingUser);
    return _AuthController(verbMap);
  }

  static _AuthController multiple(
      {AuthMode post,
      AuthMode get,
      AuthMode put,
      AuthMode patch,
      AuthMode delete}) {
    final verbMap = Map.of(verbMapTemplate)
      ..updateAll((key, value) => AuthMode.none);
    if (post != null) {
      verbMap.update(Verb.post, (value) => post);
    }
    if (get != null) {
      verbMap.update(Verb.get, (value) => get);
    }
    if (put != null) {
      verbMap.update(Verb.put, (value) => put);
    }
    if (patch != null) {
      verbMap.update(Verb.patch, (value) => patch);
    }
    if (delete != null) {
      verbMap.update(Verb.delete, (value) => delete);
    }
    return _AuthController(verbMap);
  }
}

class _AuthController extends Controller {
  _AuthController(this.authModeMap);

  final Map<Verb, AuthMode> authModeMap;

  JWT checkValid(Request request) {
    final auth = request.raw.headers.value('Authorization');
    final token = auth.replaceAll('Bearer ', '');
    return validateToken(token);
  }

  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final mode = authModeMap[stringToVerb(request.method)];
    if (mode == AuthMode.none) {
      return request;
    }
    
    final jwt = checkValid(request);
    final jwtId = jwt?.payload == null ? null : jwt.payload['id'] as int;
    final idString = request.path.variables['id'];
    final id =
        idString == null || idString.isEmpty ? null : int.parse(idString);

    if (mode == AuthMode.bearer) {
      if (jwt == null || jwtId == null) {
        return Response.unauthorized(body: {'success': false});
      }
    } else if (mode == AuthMode.isRequestingUser) {
      if (jwt == null || jwtId == null || id == null || jwtId != id) {
        return Response.unauthorized(body: {'success': false});
      }
    } else {
      return request;
    }

    final user = await User.get(jwtId);
    request.attachments.putIfAbsent('user', () => user);
    return request;
  }
}
