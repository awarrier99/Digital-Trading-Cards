import '../server.dart';

enum Resource { card, user }

enum Verb { post, get, put, patch, delete }

Verb stringToVerb(String string) {
  switch (string) {
    case 'POST':
      return Verb.post;
    case 'GET':
      return Verb.get;
    case 'PUT':
      return Verb.put;
    case 'PATCH':
      return Verb.patch;
    default:
      return Verb.delete;
  }
}

class VerbController extends Controller {
  VerbController(this.resource);

  final Resource resource;

  Future<RequestOrResponse> _commonPost(
      Request request, int id, checker) async {
    if (id == null) {
      return request;
    }

    if (await checker(id) == null) {
      return Response.notFound(body: {'success': false});
    }

    return Response.conflict(body: {'success': false});
  }

  Future<RequestOrResponse> _commonPutOrPatchOrDelete(
      Request request, int id, checker) async {
    if (id == null) {
      return notAllowed();
    }

    if (await checker(id) == null) {
      return Response.notFound(body: {'success': false});
    }

    return request;
  }

  @override
  Future<RequestOrResponse> handle(Request request) async {
    final idString = request.path.variables['id'];
    final id =
        idString == null || idString.isEmpty ? null : int.parse(idString);
    final verb = stringToVerb(request.method);

    if (resource == Resource.card) {
      if (verb == Verb.post) {
        return _commonPost(request, id, User.get);
      } else if (verb == Verb.get) {
        if (id == null) {
          return notAllowed();
        }

        final user = await User.get(id);
        if (user == null) {
          return Response.notFound(body: {'success': false});
        }

        request.attachments.putIfAbsent('cardUser', () => user);
        return request;
      }

      return _commonPutOrPatchOrDelete(request, id, User);
    } else if (resource == Resource.user) {
      if (verb == Verb.post) {
        if (id == null) {
          return request;
        }
        return notAllowed();
      } else if (verb == Verb.get) {
        if (id == null) {
          return notAllowed();
        }

        final user = request.attachments['user'];

        if (user == null) {
          return Response.notFound(body: {'success': false});
        }

        return request;
      }
    }

    return request;
  }
}
