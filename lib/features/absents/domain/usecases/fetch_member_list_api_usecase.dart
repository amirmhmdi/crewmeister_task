import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/domain/entities/members_list.dart';
import 'package:crewmeister_task/features/absents/domain/repositories/absence_repository.dart';
import 'package:dartz/dartz.dart';

class FetchMemberListApiUsecase {
  final AbsenceRepository absenceRepository;
  FetchMemberListApiUsecase({required this.absenceRepository});

  Future<Either<Failure, MembersList>> call() async {
    return await absenceRepository.fetchMemberListApi();
  }
}
