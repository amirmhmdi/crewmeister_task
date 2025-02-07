import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_status.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';
import 'package:crewmeister_task/features/absents/domain/entities/member.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Absence extends Equatable {
  final int? admitterId;
  final String admitterNote;
  final DateTime? confirmedAt;
  final DateTime createdAt;
  final int crewId;
  final DateTime endDate;
  final int id;
  final String memberNote;
  final DateTime? rejectedAt;
  final DateTime startDate;
  final AbsentType type;
  final int userId;
  final AbsentStatus absentStatus;
  Member? memberInfo;

  Absence({
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
