import 'dart:typed_data';

import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/domain/repositories/absence_repository.dart';
import 'package:dartz/dartz.dart';

class SendEmailWithICSUsecase {
  final AbsenceRepository absenceRepository;
  SendEmailWithICSUsecase({required this.absenceRepository});

  Future<Either<Failure, bool>> call(Uint8List icsFileByte, String email) async {
    return await absenceRepository.sendEmailWithICS(icsFileByte, email);
  }
}
