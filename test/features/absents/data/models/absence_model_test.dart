import 'package:crewmeister_task/features/absents/data/models/absence_model.dart';
import 'package:crewmeister_task/features/absents/data/models/enums/absent_status.dart';
import 'package:crewmeister_task/features/absents/data/models/enums/absent_type.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_status.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../res/absence_json.dart';

void main() {
  group('AbsenceModel', () {
    test('should correctly deserialize from JSON', () {
      final absenceModel = AbsenceModel.fromJson(absenceModelJson);

      expect(absenceModel.admitterId, '123');
      expect(absenceModel.admitterNote, 'Approved leave');
      expect(absenceModel.confirmedAt, '2025-01-01');
      expect(absenceModel.createdAt, '2025-01-01');
      expect(absenceModel.crewId, 1);
      expect(absenceModel.endDate, '2025-01-10');
      expect(absenceModel.id, 101);
      expect(absenceModel.memberNote, 'Feeling unwell');
      expect(absenceModel.rejectedAt, isNull);
      expect(absenceModel.startDate, '2025-01-05');
      expect(absenceModel.type, AbsentTypeDTO.sickness);
      expect(absenceModel.userId, 202);
    });

    test('should correctly serialize to JSON', () {
      final absenceModel = AbsenceModel(
        admitterId: '123',
        admitterNote: 'Approved leave',
        confirmedAt: '2025-01-01',
        createdAt: '2025-01-01',
        crewId: 1,
        endDate: '2025-01-10',
        id: 101,
        memberNote: 'Feeling unwell',
        rejectedAt: null,
        startDate: '2025-01-05',
        type: AbsentTypeDTO.sickness,
        userId: 202,
      );

      final Map<String, dynamic> jsonResult = absenceModel.toJson();

      expect(jsonResult, absenceModelJson);
    });

    test('should correctly update absentStatusDTO based on confirmedAt and rejectedAt', () {
      // Case 1: confirmedAt is not null
      final absenceModel1 = AbsenceModel.fromJson(absenceModelJson);
      absenceModel1.absentStatusUpdater();
      expect(absenceModel1.absentStatusDTO, AbsentStatusDTO.confirmed);

      // Case 2: rejectedAt is not null
      final absenceModel2 = AbsenceModel.fromJson({
        ...absenceModelJson,
        'confirmedAt': null,
        'rejectedAt': '2025-01-03',
      });
      absenceModel2.absentStatusUpdater();
      expect(absenceModel2.absentStatusDTO, AbsentStatusDTO.rejected);

      // Case 3: Both confirmedAt and rejectedAt are null
      final absenceModel3 = AbsenceModel.fromJson({
        ...absenceModelJson,
        'confirmedAt': null,
        'rejectedAt': null,
      });
      absenceModel3.absentStatusUpdater();
      expect(absenceModel3.absentStatusDTO, AbsentStatusDTO.requested);
    });

    test('should correctly convert to domain model', () {
      final absenceModel = AbsenceModel.fromJson(absenceModelJson);
      absenceModel.absentStatusUpdater();

      final absence = absenceModel.toDomain();

      expect(absence.admitterId, '123');
      expect(absence.admitterNote, 'Approved leave');
      expect(absence.confirmedAt, DateTime.parse('2025-01-01'));
      expect(absence.createdAt, DateTime.parse('2025-01-01'));
      expect(absence.crewId, 1);
      expect(absence.endDate, DateTime.parse('2025-01-10'));
      expect(absence.id, 101);
      expect(absence.memberNote, 'Feeling unwell');
      expect(absence.rejectedAt, isNull);
      expect(absence.startDate, DateTime.parse('2025-01-05'));
      expect(absence.type, AbsentType.sickness);
      expect(absence.userId, 202);
      expect(absence.absentStatus, AbsentStatus.confirmed);
    });
  });
}
