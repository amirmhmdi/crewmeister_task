import 'package:crewmeister_task/features/absents/domain/entities/absence.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_status.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Absence', () {
    final absence = Absence(
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
      type: AbsentType.sickness,
      userId: 202,
      absentStatus: AbsentStatus.confirmed,
    );

    test('should create an Absence instance correctly', () {
      expect(absence.admitterId, '123');
      expect(absence.admitterNote, 'Approved leave');
      expect(absence.confirmedAt, '2025-01-01');
      expect(absence.createdAt, '2025-01-01');
      expect(absence.crewId, 1);
      expect(absence.endDate, '2025-01-10');
      expect(absence.id, 101);
      expect(absence.memberNote, 'Feeling unwell');
      expect(absence.rejectedAt, isNull);
      expect(absence.startDate, '2025-01-05');
      expect(absence.type, AbsentType.sickness);
      expect(absence.userId, 202);
      expect(absence.absentStatus, AbsentStatus.confirmed);
    });

    test('should support equality comparison', () {
      final absence1 = Absence(
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
        type: AbsentType.sickness,
        userId: 202,
        absentStatus: AbsentStatus.confirmed,
      );

      final absence2 = Absence(
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
        type: AbsentType.sickness,
        userId: 202,
        absentStatus: AbsentStatus.confirmed,
      );

      final absence3 = Absence(
        admitterId: '456',
        admitterNote: 'Rejected leave',
        confirmedAt: '2025-01-02',
        createdAt: '2025-01-01',
        crewId: 2,
        endDate: '2025-01-15',
        id: 102,
        memberNote: 'Need personal time off',
        rejectedAt: '2025-01-04',
        startDate: '2025-01-12',
        type: AbsentType.vacation,
        userId: 203,
        absentStatus: AbsentStatus.rejected,
      );

      expect(absence1, equals(absence2));
      expect(absence1, isNot(equals(absence3)));
    });

    test('should return correct props for Equatable', () {
      expect(absence.props, [
        '123',
        'Approved leave',
        '2025-01-01',
        '2025-01-01',
        1,
        '2025-01-10',
        101,
        'Feeling unwell',
        null,
        '2025-01-05',
        AbsentType.sickness,
        202,
        AbsentStatus.confirmed,
      ]);
    });
  });
}
