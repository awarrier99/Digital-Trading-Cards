import 'package:server/server.dart';

//this is the controller to handle companies in our app. In the database this is a look up table and users can pick from already added companies
//or add their own company if it is not already in the table
class CompanyController extends ResourceController {
  //this is the api route to get companies from the table
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
  //this is the route to add a company if it is not already in the database table
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
