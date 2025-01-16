import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absences_list.dart';
import 'package:crewmeister_task/features/absents/domain/repositories/absence_repository.dart';
import 'package:dartz/dartz.dart';

class FetchAbsenceListApiUsecase {
  final AbsenceRepository absenceRepository;
  FetchAbsenceListApiUsecase({required this.absenceRepository});

  Future<Either<Failure, AbsencesList>> call() async {
    return await absenceRepository.fetchAbsencesListApi();
  }
}
