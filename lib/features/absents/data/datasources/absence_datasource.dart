import 'package:http/http.dart' as http;

abstract class AbsenceDatasource {
  Future<http.Response> fetchAbsenceListApi();

  Future<http.Response> fetchMembersListApi();
}