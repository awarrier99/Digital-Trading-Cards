import 'package:server/server.dart';

class CompanyController extends ResourceController {
  @Operation.get('pattern')
  Future<Response> getMatchingCompanies(
      @Bind.path('pattern') String pattern) async {
    try {
      final companies = await Company.find(pattern);
      return Response.ok({
        'success': true,
        'companies': companies.map((e) => e.asMap()).toList()
      });
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to get matching companies:');
      return Response.serverError(body: {'success': false});
    }
  }

  @Operation.post()
  Future<Response> createCompany(@Bind.body() Company company) async {
    try {
      await company.save();
      return Response.ok({'success': true});
    } catch (err, stackTrace) {
      logError(err,
          stackTrace: stackTrace,
          message: 'An error occurred while trying to create a company:');
      return Response.serverError(body: {'success': false});
    }
  }
}
