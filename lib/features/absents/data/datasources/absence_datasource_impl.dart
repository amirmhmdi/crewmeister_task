import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/data/datasources/absence_datasource.dart';
import 'package:http/http.dart' as http;

class AbsenceDatasourceImpl implements AbsenceDatasource {
  @override
  Future<http.Response> fetchAbsenceListApi() async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://raw.githubusercontent.com/crewmeister/frontend-coding-challenge/refs/heads/master/api/json_files/absences.json'),
        headers: {'Content-Type': 'application/json'},
      );
      return response;
    } catch (e) {
      throw ServerFailure('Server Failure');
    }
  }

  @override
  Future<http.Response> fetchMembersListApi() async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://raw.githubusercontent.com/crewmeister/frontend-coding-challenge/refs/heads/master/api/json_files/members.json'),
        headers: {'Content-Type': 'application/json'},
      );
      return response;
    } catch (e) {
      throw ServerFailure('Server Failure');
    }
  }
}
