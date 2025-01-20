import 'dart:typed_data';

import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/data/datasources/absence_datasource.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

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

  @override
  Future<bool> sendEmailWithICS(Uint8List icsFileByte, String email) async {
    GoogleSignInAccount? account = await GoogleSignIn(scopes: ['https://mail.google.com/']).signIn();

    if (account == null) {
      return false;
    }

    GoogleSignInAuthentication auth = await account.authentication;
    String token = auth.accessToken!;

    final smtpServer = gmailSaslXoauth2(account.email, token);

    final message = Message()
      ..from = Address('crewmeisterabsencetest@gmail.com')
      ..recipients.add(email)
      ..subject = 'Absence Event'
      ..text = 'Please find the attached absence event.'
      ..attachments.add(StreamAttachment(
        Stream.value(List<int>.from(icsFileByte)),
        'text/calendar',
        fileName: 'absence_event.ics',
      ));

    try {
      final SendReport sendReport = await send(message, smtpServer, timeout: Duration(seconds: 10));
      return true;
    } catch (e) {
      return false;
    }
  }
}
