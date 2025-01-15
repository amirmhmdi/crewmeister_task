import 'package:crewmeister_task/features/absents/data/models/member_model.dart';
import 'package:crewmeister_task/features/absents/domain/entities/members_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'members_list_model.g.dart';

@JsonSerializable()
class MembersListModel {
  String message;
  MemberModel payload;

  MembersListModel({
    required this.message,
    required this.payload,
  });

  factory MembersListModel.fromJson(Map<String, dynamic> json) => _$MembersListModelFromJson(json);

  Map<String, dynamic> toJson() => _$MembersListModelToJson(this);

  MembersList toDomin() {
    return MembersList(message: message, payload: payload.toDomain());
  }
}
