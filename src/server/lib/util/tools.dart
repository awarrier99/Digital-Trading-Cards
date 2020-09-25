import '../server.dart';

Response notAllowed() {
  return Response(
      405, {'Content-Type': 'application/json'}, {'success': false});
}

void logError(dynamic err, {StackTrace stackTrace, String message}) {
  if (message != null && message.isNotEmpty) {
    print(message);
  }
  String errStr = err.toString();
  if (err is JWTError) {
    errStr = err.message;
  }
  print(errStr);
  if (stackTrace != null) {
    print(stackTrace);
  }
}
