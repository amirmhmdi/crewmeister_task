import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absences_list.dart';
import 'package:crewmeister_task/features/absents/domain/entities/members_list.dart';
import 'package:dartz/dartz.dart';

abstract class AbsenceRepository {
  Future<Either<Failure, MembersList>> fetchMemberListApi();

  Future<Either<Failure, AbsencesList>> fetchAbsencesListApi();
}
