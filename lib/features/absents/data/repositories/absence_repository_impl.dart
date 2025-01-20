import 'dart:convert';
import 'dart:typed_data';
import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/data/datasources/absence_datasource.dart';
import 'package:crewmeister_task/features/absents/data/models/absences_list_model.dart';
import 'package:crewmeister_task/features/absents/data/models/members_list_model.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absences_list.dart';
import 'package:crewmeister_task/features/absents/domain/entities/members_list.dart';
import 'package:crewmeister_task/features/absents/domain/repositories/absence_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AbsenceRepositoryImpl extends AbsenceRepository {
  final AbsenceDatasource absenceDatasource;

  AbsenceRepositoryImpl({required this.absenceDatasource});

  @override
  Future<Either<Failure, AbsencesList>> fetchAbsencesListApi() async {
    try {
      http.Response response = await absenceDatasource.fetchAbsenceListApi();
      if (response.statusCode == 200) {
        AbsencesListModel absencesListModel = AbsencesListModel.fromJson(jsonDecode(response.body));
        return Right(absencesListModel.toDomain());
      } else {
        return Left(ServerFailure('Server Failure'));
      }
    } catch (e) {
      return Left(ServerFailure('Somethings were wrong'));
    }
  }

  @override
  Future<Either<Failure, MembersList>> fetchMemberListApi() async {
    try {
      http.Response response = await absenceDatasource.fetchMembersListApi();
      if (response.statusCode == 200) {
        MembersListModel membersListModel = MembersListModel.fromJson(jsonDecode(response.body));
        return Right(membersListModel.toDomin());
      } else {
        return Left(ServerFailure('Server Failure'));
      }
    } catch (e) {
      return Left(ServerFailure('Somethings were wrong'));
    }
  }

  @override
  Future<Either<Failure, bool>> sendEmailWithICS(Uint8List icsFileByte, String email) async {
    bool response = await absenceDatasource.sendEmailWithICS(icsFileByte, email);
    if (response == true) {
      return Right(true);
    } else {
      return Left(EmailFailure('.ics File failed to send'));
    }
  }
}
