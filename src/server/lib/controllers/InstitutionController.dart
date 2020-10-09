import '../server.dart';

class InstitutionController extends ResourceController {
  @Operation.get('pattern')
  Future<Response> getMatchingInstitutions(
      @Bind.path('pattern') String pattern) async {
    try {
      final institutions = await Institution.find(pattern);
      return Response.ok({
        'success': true,
        'institutions': institutions.map((e) => e.asMap()).toList()
      });
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message:
              'An error occurred while trying to get matching institutions:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.post()
  Future<Response> createInstitution(
      @Bind.body() Institution institution) async {
    try {
      await institution.save();
      return Response.ok({'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create an institution:');
      return Response.serverError(body: {'success': false});
    }
  }
}
