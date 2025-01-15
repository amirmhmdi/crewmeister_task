// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => MemberModel(
      crewId: (json['crewId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      image: json['image'] as String,
      name: json['name'] as String,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'crewId': instance.crewId,
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'userId': instance.userId,
    };
