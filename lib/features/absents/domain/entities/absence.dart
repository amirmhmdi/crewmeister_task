import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_status.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';
import 'package:equatable/equatable.dart';

class Absence extends Equatable {
  final String? admitterId;
  final String admitterNote;
  final String? confirmedAt;
  final String createdAt;
  final int crewId;
  final String endDate;
  final int id;
  final String memberNote;
  final String? rejectedAt;
  final String startDate;
  final AbsentType type;
  final int userId;
  final AbsentStatus absentStatus;

  const Absence({
    required this.admitterId,
    required this.admitterNote,
    required this.confirmedAt,
    required this.createdAt,
    required this.crewId,
    required this.endDate,
    required this.id,
    required this.memberNote,
    required this.rejectedAt,
    required this.startDate,
    required this.type,
    required this.userId,
    required this.absentStatus,
  });

  @override
  List<Object?> get props => [admitterId, admitterNote, confirmedAt, createdAt, crewId, endDate, id, memberNote, rejectedAt, startDate, type, userId, absentStatus];
}
