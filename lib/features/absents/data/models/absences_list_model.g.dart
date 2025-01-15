// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absences_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsencesListModel _$AbsencesListModelFromJson(Map<String, dynamic> json) =>
    AbsencesListModel(
      message: json['message'] as String,
      payload: AbsenceModel.fromJson(json['payload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AbsencesListModelToJson(AbsencesListModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'payload': instance.payload,
    };
