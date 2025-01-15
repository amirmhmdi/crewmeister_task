// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsenceModel _$AbsenceModelFromJson(Map<String, dynamic> json) => AbsenceModel(
      admitterId: json['admitterId'] as String?,
      admitterNote: json['admitterNote'] as String,
      confirmedAt: json['confirmedAt'] as String?,
      createdAt: json['createdAt'] as String,
      crewId: (json['crewId'] as num).toInt(),
      endDate: json['endDate'] as String,
      id: (json['id'] as num).toInt(),
      memberNote: json['memberNote'] as String,
      rejectedAt: json['rejectedAt'] as String?,
      startDate: json['startDate'] as String,
      type: $enumDecode(_$AbsentTypeDTOEnumMap, json['type']),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$AbsenceModelToJson(AbsenceModel instance) =>
    <String, dynamic>{
      'admitterId': instance.admitterId,
      'admitterNote': instance.admitterNote,
      'confirmedAt': instance.confirmedAt,
      'createdAt': instance.createdAt,
      'crewId': instance.crewId,
      'endDate': instance.endDate,
      'id': instance.id,
      'memberNote': instance.memberNote,
      'rejectedAt': instance.rejectedAt,
      'startDate': instance.startDate,
      'type': _$AbsentTypeDTOEnumMap[instance.type]!,
      'userId': instance.userId,
    };

const _$AbsentTypeDTOEnumMap = {
  AbsentTypeDTO.sickness: 'sickness',
  AbsentTypeDTO.vacation: 'vacation',
};
