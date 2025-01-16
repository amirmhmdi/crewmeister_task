import 'package:crewmeister_task/features/absents/data/models/absence_model.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absence.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absences_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'absences_list_model.g.dart';

@JsonSerializable()
class AbsencesListModel {
  String message;
  List<AbsenceModel> payload;

  AbsencesListModel({
    required this.message,
    required this.payload,
  });

  factory AbsencesListModel.fromJson(Map<String, dynamic> json) => _$AbsencesListModelFromJson(json);

  Map<String, dynamic> toJson() => _$AbsencesListModelToJson(this);

  AbsencesList toDomain() {
    List<Absence> absenceListDomain = []; 
    for (AbsenceModel element in payload) {
      absenceListDomain.add(element.toDomain());
    }
    return AbsencesList(
      message: message,
      payload: absenceListDomain,
    );
  }
}
