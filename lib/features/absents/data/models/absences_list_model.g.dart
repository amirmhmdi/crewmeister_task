// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absences_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsencesListModel _$AbsencesListModelFromJson(Map<String, dynamic> json) =>
    AbsencesListModel(
      message: json['message'] as String,
      payload: (json['payload'] as List<dynamic>)
          .map((e) => AbsenceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AbsencesListModelToJson(AbsencesListModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'payload': instance.payload.map((e) => e.toJson()).toList(),
    };
