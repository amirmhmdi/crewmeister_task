import 'package:crewmeister_task/features/absents/data/models/absence_model.dart';
import 'package:crewmeister_task/features/absents/data/models/absences_list_model.dart';
import 'package:crewmeister_task/features/absents/data/models/enums/absent_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../res/absence_json.dart';

void main() {
  group('AbsencesListModel', () {
    final absencesListJson = {
      'message': 'Success',
      'payload': [absenceModelJson],
    };

    final absenceModel = AbsenceModel.fromJson(absenceModelJson);

    final absencesListModel = AbsencesListModel(
      message: 'Success',
      payload: [absenceModel],
    );

    test('should correctly deserialize from JSON', () {
      final result = AbsencesListModel.fromJson(absencesListJson);

      expect(result.message, 'Success');
      expect(result.payload.length, 1);
      expect(result.payload.first.type, AbsentTypeDTO.sickness);
    });

    test('should correctly serialize to JSON', () {
      final jsonResult = absencesListModel.toJson();

      expect(jsonResult, absencesListJson);
    });

    test('should correctly convert to domain model', () {
      final domainResult = absencesListModel.toDomain();

      expect(domainResult.message, 'Success');
      expect(domainResult.payload.length, 1);
      expect(domainResult.payload.first.admitterNote, 'Approved leave');
    });
  });
}
