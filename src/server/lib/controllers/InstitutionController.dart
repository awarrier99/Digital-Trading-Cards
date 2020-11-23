import '../server.dart';

//this is the server controller to get/create new insituttiions. This is a look up table in the database
class InstitutionController extends ResourceController {
  //api call to get institution if it is already in the database
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
  //api call to create a new institution if it is not in the table already
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
