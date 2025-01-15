import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_status.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';

class Absence {
  String? admitterId;
  String admitterNote;
  String? confirmedAt;
  String createdAt;
  int crewId;
  String endDate;
  int id;
  String memberNote;
  String? rejectedAt;
  String startDate;
  AbsentType type;
  int userId;
  AbsentStatus absentStatus;

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
}
