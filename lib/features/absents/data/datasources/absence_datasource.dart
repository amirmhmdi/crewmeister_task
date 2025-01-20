import 'dart:typed_data';

import 'package:http/http.dart' as http;

abstract class AbsenceDatasource {
  Future<http.Response> fetchAbsenceListApi();

  Future<http.Response> fetchMembersListApi();

  Future<bool> sendEmailWithICS(Uint8List icsFileByte , String email);
}