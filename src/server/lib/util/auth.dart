import '../server.dart';

String generateToken(User user) {
  final key = ServerChannel.config.jwt.key;
  final aud = ServerChannel.config.jwt.aud;
  final iss = ServerChannel.config.jwt.iss;

  final jwt = JWT(
    payload: {'id': user.id},
    audience: aud,
    issuer: iss,
    subject: 'wisteria|dtc@${user.id}'
  );
  final token = jwt.sign(SecretKey(key), expiresIn: const Duration(hours: 1));
  return token;
}

JWT validateToken(String token) {
  final key = ServerChannel.config.jwt.key;
  final aud = ServerChannel.config.jwt.aud;
  final iss = ServerChannel.config.jwt.iss;

  try {
    final jwt = JWT.verify(token, SecretKey(key));
    final jwtId = jwt.payload['id'] as int;
    if (jwt.audience != aud || jwt.issuer != iss || jwt.subject != 'wisteria|dtc@$jwtId') {
      throw JWTInvalidError('JWT claims are invalid');
    }
    return jwt;
  } catch (err, stackTrace) {
    logError(err, stackTrace: stackTrace, message: 'An error occurred while validating a token:');
    return null;
  }
}
