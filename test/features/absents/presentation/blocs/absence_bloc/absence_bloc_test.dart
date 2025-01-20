import 'package:bloc_test/bloc_test.dart';
import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absence.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absences_list.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_status.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';
import 'package:crewmeister_task/features/absents/domain/entities/filter.dart';
import 'package:crewmeister_task/features/absents/domain/entities/member.dart';
import 'package:crewmeister_task/features/absents/domain/entities/members_list.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/fetch_absence_list_api_usecase.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/fetch_member_list_api_usecase.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/send_email_with_ics_usecase.dart';
import 'package:crewmeister_task/features/absents/presentation/blocs/absence_bloc/absence_bloc.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchAbsenceListApiUsecase extends Mock implements FetchAbsenceListApiUsecase {}

class MockFetchMemberListApiUsecase extends Mock implements FetchMemberListApiUsecase {}

class MockSendEmailWithICSUsecase extends Mock implements SendEmailWithICSUsecase {}

void main() {
  late AbsenceBloc absenceBloc;
  late MockFetchAbsenceListApiUsecase mockFetchAbsenceListApiUsecase;
  late MockFetchMemberListApiUsecase mockFetchMemberListApiUsecase;
  late MockSendEmailWithICSUsecase mockSendEmailWithICSUsecase;

  setUp(() {
    mockFetchAbsenceListApiUsecase = MockFetchAbsenceListApiUsecase();
    mockFetchMemberListApiUsecase = MockFetchMemberListApiUsecase();
    mockSendEmailWithICSUsecase = MockSendEmailWithICSUsecase();
    absenceBloc = AbsenceBloc(
      fetchAbsenceListApiUsecase: mockFetchAbsenceListApiUsecase,
      fetchMemberListApiUsecase: mockFetchMemberListApiUsecase,
      sendEmailWithICSUsecase: mockSendEmailWithICSUsecase,
    );
  });

  tearDown(() {
    absenceBloc.close();
  });

  final sampleAbsence = Absence(
    admitterId: 123,
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

  final sampleMember = Member(
    crewId: 1,
    id: 101,
    image: '',
    name: 'Amir',
    userId: 202,
  );

  final mockAbsencesList = AbsencesList(
    message: 'message',
    payload: [sampleAbsence],
  );

  final mockMemberList = MembersList(message: 'message', payload: [sampleMember]);
  group('AbsenceBloc', () {
    test('initial state is AbsenceLoadingState', () {
      expect(absenceBloc.state, AbsenceLoadingState());
    });

    blocTest<AbsenceBloc, AbsenceState>(
      'emits [AbsenceLoadingState, AbsenceloadedState] when AbsenceListFetchEvent succeeds',
      build: () {
        when(() => mockFetchAbsenceListApiUsecase.call()).thenAnswer((_) async => Right(mockAbsencesList));
        when(() => mockFetchMemberListApiUsecase.call()).thenAnswer((_) async => Right(mockMemberList));
        return absenceBloc;
      },
      act: (bloc) => bloc.add(AbsenceListFetchEvent()),
      expect: () => [
        AbsenceLoadingState(),
        AbsenceloadedState(absenceList: [sampleAbsence], totalAbcenceCount: 1),
      ],
    );

    blocTest<AbsenceBloc, AbsenceState>(
      'emits [AbsenceLoadingState, AbsenceFailurState] when AbsenceListFetchEvent fails',
      build: () {
        when(() => mockFetchAbsenceListApiUsecase.call()).thenAnswer((_) async => Left(ServerFailure('API error')));
        return absenceBloc;
      },
      act: (bloc) => bloc.add(AbsenceListFetchEvent()),
      expect: () => [
        AbsenceLoadingState(),
        AbsenceFailurState(errorMessage: 'API error'),
      ],
    );

    blocTest<AbsenceBloc, AbsenceState>(
      'emits [AbsenceLoadingState, AbsenceloadedState] when filtering absences with AbsenceFilterEvent',
      build: () {
        absenceBloc.testAbsencesList = mockAbsencesList;
        absenceBloc.showingAbsenceList = [sampleAbsence];
        return absenceBloc;
      },
      act: (bloc) => bloc.add(
        AbsenceFilterEvent(
          selectedFilter: FilterAbsence(
            absenceType: AbsentType.sickness,
            startDate: DateTime.parse('2024-01-01'),
            endDate: DateTime.parse('2026-01-10'),
          ),
        ),
      ),
      expect: () => [
        AbsenceLoadingState(),
        AbsenceUpdateFiltersListState(),
        AbsenceloadedState(absenceList: [sampleAbsence], totalAbcenceCount: 1),
      ],
    );

    blocTest<AbsenceBloc, AbsenceState>(
      'emits [AbsenceloadedState] with filtered absences when date range does not match any absence',
      build: () {
        absenceBloc.showingAbsenceList = [sampleAbsence];
        return absenceBloc;
      },
      act: (bloc) => bloc.add(
        AbsenceFilterEvent(
          selectedFilter: FilterAbsence(
            absenceType: AbsentType.sickness,
            startDate: DateTime.parse('2025-02-01'),
            endDate: DateTime.parse('2025-02-10'),
          ),
        ),
      ),
      expect: () => [
        AbsenceLoadingState(),
        AbsenceUpdateFiltersListState(),
        AbsenceloadedState(absenceList: [], totalAbcenceCount: 0),
      ],
    );
  });
}
