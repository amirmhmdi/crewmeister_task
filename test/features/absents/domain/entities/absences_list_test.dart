import 'package:crewmeister_task/features/absents/domain/entities/absence.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absences_list.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_status.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AbsencesList', () {
    final absence = Absence(
      admitterId: '123',
      admitterNote: 'Approved leave',
      confirmedAt: DateTime.parse('2025-01-01'),
      createdAt: DateTime.parse('2025-01-01'),
      crewId: 1,
      endDate: DateTime.parse('2025-01-10'),
      id: 101,
      memberNote: 'Feeling unwell',
      rejectedAt: null,
      startDate: DateTime.parse('2025-01-05'),
      type: AbsentType.sickness,
      userId: 202,
      absentStatus: AbsentStatus.confirmed,
    );

    final absencesList = AbsencesList(
      message: 'Success',
      payload: [absence],
    );

    test('should create an AbsencesList instance correctly', () {
      expect(absencesList.message, 'Success');
      expect(absencesList.payload, [absence]);
    });

    test('should support equality comparison', () {
      final absencesList1 = AbsencesList(
        message: 'Success',
        payload: [absence],
      );

      final absencesList2 = AbsencesList(
        message: 'Success',
        payload: [absence],
      );

      final absencesList3 = AbsencesList(
        message: 'Failed',
        payload: [absence],
      );

      expect(absencesList1, equals(absencesList2));
      expect(absencesList1, isNot(equals(absencesList3)));
    });

    test('should return correct props for Equatable', () {
      expect(absencesList.props, [
        'Success',
        [absence]
      ]);
    });
  });
}
