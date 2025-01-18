import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';

class FilterAbsence {
  final AbsentType absenceType;
  final DateTime? startDate;
  final DateTime? endDate;

  FilterAbsence({required this.absenceType, required this.startDate, required this.endDate});
}
