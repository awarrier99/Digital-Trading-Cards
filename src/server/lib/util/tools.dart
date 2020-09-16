import '../server.dart';

Response notAllowed() {
  return Response(405, {'Content-Type': 'application/json'}, {'success': false});
}
