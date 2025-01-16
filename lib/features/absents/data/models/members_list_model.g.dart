// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembersListModel _$MembersListModelFromJson(Map<String, dynamic> json) =>
    MembersListModel(
      message: json['message'] as String,
      payload: (json['payload'] as List<dynamic>)
          .map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MembersListModelToJson(MembersListModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'payload': instance.payload.map((e) => e.toJson()).toList(),
    };
