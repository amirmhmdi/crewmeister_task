import 'package:crewmeister_task/features/absents/domain/entities/member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable()
class MemberModel {
  int crewId;
  int id;
  String image;
  String name;
  int userId;

  MemberModel({
    required this.crewId,
    required this.id,
    required this.image,
    required this.name,
    required this.userId,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);

  Member toDomain() {
    return Member(
      crewId: crewId,
      id: id,
      image: image,
      name: name,
      userId: userId,
    );
  }
}
