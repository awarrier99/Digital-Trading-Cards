import 'package:server/models/db/Event.dart';

import '../server.dart';
//this is a helper file that helps with making API calls
enum Resource {
  card,
  user,
  connection,
  institution,
  field,
  skill,
  interest,
  company,
  event,
  upcomingEvents
}

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
  //handling post api calls
  Future<RequestOrResponse> _commonPost(
      Request request, int id, Function checker) async {
    if (id == null) {
      return request;
    }

    if (await checker(id) == null) {
      return Response.notFound(body: {'success': false});
    }

    return Response.conflict(body: {'success': false});
  }
  //handling update api calls
  Future<RequestOrResponse> _commonPutOrPatchOrDelete(
      Request request, int id, Function checker,
      {String key}) async {
    if (id == null) {
      return notAllowed();
    }

    final obj = await checker(id);
    if (obj == null) {
      return Response.notFound(body: {'success': false});
    }

    if (key != null) {
      request.attachments.putIfAbsent(key, () => obj);
    }

    return request;
  }
  //handling the api calls based on what's being called
  @override
  Future<RequestOrResponse> handle(Request request) async {
    final idString = request.path.variables['id'];
    final pattern = request.path.variables['pattern'];
    final id =
        idString == null || idString.isEmpty ? null : int.tryParse(idString);
    String username;
    if (id == null) {
      username = idString;
    }
    final verb = stringToVerb(request.method);

    if (resource == Resource.card) {
      if (verb == Verb.post) {
        return _commonPost(request, id, User.get);
      } else if (verb == Verb.get) {
        if (id == null && username == null) {
          return notAllowed();
        }

        User user;
        if (id != null) {
          user = await User.get(id);
        } else {
          user = await User.getByUsername(username);
        }

        if (user == null) {
          return Response.notFound(body: {'success': false});
        }

        request.attachments.putIfAbsent('cardUser', () => user);
        return request;
      }

      return _commonPutOrPatchOrDelete(request, id, User.get);
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
    } else if (resource == Resource.connection) {
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

        request.attachments.putIfAbsent('connectionUser', () => user);
        return request;
      }

      return _commonPutOrPatchOrDelete(request, id, Connection.get,
          key: 'connection');
    } else if (resource == Resource.event) {
      if (verb == Verb.post) {
        return _commonPost(request, id, Event.get);
      } else if (verb == Verb.get) {
        if (id == null) {
          return notAllowed();
        }

        final user = await Event.get(id);
        if (user == null) {
          return Response.notFound(body: {'success': false});
        }

        request.attachments.putIfAbsent('connectionUser', () => user);
      }
    } else if (resource == Resource.upcomingEvents) {
      if (verb == Verb.post) {
        return _commonPost(request, id, Event.get);
      } else if (verb == Verb.get) {
        if (id == null) {
          return notAllowed();
        }

        final upcomingEvents = await Event.get(id);
        if (upcomingEvents == null) {
          return Response.notFound(body: {'success': false});
        }
      }
    } else if (resource == Resource.institution ||
        resource == Resource.field ||
        resource == Resource.skill ||
        resource == Resource.interest ||
        resource == Resource.company) {
      if (verb == Verb.post) {
        if (pattern != null) {
          return notAllowed();
        }
        return request;
      }
    }

    return request;
  }
}
