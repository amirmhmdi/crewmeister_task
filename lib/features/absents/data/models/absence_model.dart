import 'package:crewmeister_task/features/absents/data/models/enums/absent_status.dart';
import 'package:crewmeister_task/features/absents/data/models/enums/absent_type.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absence.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_status.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'absence_model.g.dart';

@JsonSerializable()
class AbsenceModel {
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
  AbsentTypeDTO type;
  int userId;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late AbsentStatusDTO absentStatusDTO;

  AbsenceModel({
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
  });

  factory AbsenceModel.fromJson(Map<String, dynamic> json) => _$AbsenceModelFromJson(json)..absentStatusUpdater();

  Map<String, dynamic> toJson() => _$AbsenceModelToJson(this);

  absentStatusUpdater() {
    if (confirmedAt != null) {
      absentStatusDTO = AbsentStatusDTO.confirmed;
    } else if (rejectedAt != null) {
      absentStatusDTO = AbsentStatusDTO.rejected;
    } else {
      absentStatusDTO = AbsentStatusDTO.requested;
    }
  }

  Absence toDomain() {
    return Absence(
      admitterId: admitterId,
      admitterNote: admitterNote,
      confirmedAt: parseNullableDate(confirmedAt),
      createdAt: parseNonNullableDate(createdAt),
      crewId: crewId,
      endDate: parseNonNullableDate(endDate),
      id: id,
      memberNote: memberNote,
      rejectedAt: parseNullableDate(rejectedAt),
      startDate: parseNonNullableDate(startDate),
      type: _dTOtoAbsentType(type),
      userId: userId,
      absentStatus: _dTOtoAbsentStatus(absentStatusDTO),
    );
  }

  AbsentStatus _dTOtoAbsentStatus(AbsentStatusDTO absentStatusDTO) {
    switch (absentStatusDTO) {
      case AbsentStatusDTO.confirmed:
        return AbsentStatus.confirmed;
      case AbsentStatusDTO.rejected:
        return AbsentStatus.rejected;
      case AbsentStatusDTO.requested:
        return AbsentStatus.requested;
    }
  }

  AbsentType _dTOtoAbsentType(AbsentTypeDTO absentTypeDTO) {
    switch (absentTypeDTO) {
      case AbsentTypeDTO.vacation:
        return AbsentType.vacation;
      case AbsentTypeDTO.sickness:
        return AbsentType.sickness;
    }
  }

  // Possible solution to Not using two function
  // T? safeParseDate<T>(String? dateString) {
  //   if (dateString == null) return null as T?;
  //   try {
  //     return DateTime.parse(dateString) as T?;
  //   } catch (e) {
  //     return null as T?;
  //   }
  // }

  DateTime parseNonNullableDate(String dateString) {
    return DateTime.parse(dateString);
  }

  DateTime? parseNullableDate(String? dateString) {
    if (dateString == null) return null;

    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }
}
