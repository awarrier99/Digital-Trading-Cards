import 'package:server/server.dart';

class FieldController extends ResourceController {
  @Operation.get('pattern')
  Future<Response> getMatchingFields(
      @Bind.path('pattern') String pattern) async {
    try {
      final fields = await Field.find(pattern);
      return Response.ok(
          {'success': true, 'fields': fields.map((e) => e.asMap()).toList()});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get matching fields:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.post()
  Future<Response> createField(@Bind.body() Field field) async {
    try {
      await field.save();
      return Response.ok({'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create a field:');
      return Response.serverError(body: {'success': false});
    }
  }
}
