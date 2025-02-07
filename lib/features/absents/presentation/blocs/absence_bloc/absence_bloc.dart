import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absence.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absences_list.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';
import 'package:crewmeister_task/features/absents/domain/entities/filter.dart';
import 'package:crewmeister_task/features/absents/domain/entities/member.dart';
import 'package:crewmeister_task/features/absents/domain/entities/members_list.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/fetch_absence_list_api_usecase.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/fetch_member_list_api_usecase.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/send_email_with_ics_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'absence_event.dart';
part 'absence_state.dart';

class AbsenceBloc extends Bloc<AbsenceEvent, AbsenceState> {
  final FetchAbsenceListApiUsecase fetchAbsenceListApiUsecase;
  final FetchMemberListApiUsecase fetchMemberListApiUsecase;
  final SendEmailWithICSUsecase sendEmailWithICSUsecase;
  final bool _isSinglePageApproch;
  AbsencesList? _absencesList;
  int _currentPageIndex = 1;
  List<Absence> showingAbsenceList = [];
  FilterAbsence chosenFilter = FilterAbsence(absenceType: AbsentType.all, startDate: null, endDate: null);

  int getCurrentPageIndex() => _currentPageIndex;

  int getTotalPages() {
    if (showingAbsenceList.length % 10 == 0) {
      return (showingAbsenceList.length / 10).toInt();
    } else {
      return (showingAbsenceList.length / 10).toInt() + 1;
    }
  }

  AbsenceBloc({
    required this.fetchAbsenceListApiUsecase,
    required this.fetchMemberListApiUsecase,
    required this.sendEmailWithICSUsecase,
    required dynamic isSinglePageApproch,
  })  : _isSinglePageApproch = isSinglePageApproch,
        super(AbsenceLoadingState()) {
    on<AbsenceEvent>(
      (AbsenceEvent event, Emitter<AbsenceState> emit) async {
        if (event is AbsenceListFetchEvent) return absenceListFetch(event, emit);
        if (event is AbsenceListLoadmoreEvent) return absenceListLoadmore(event, emit);
        if (event is AbsenceFilterEvent) return absenceFilter(event, emit);
        if (event is AbsenceListSentEmailWithICSEvent) return absenceSendEmailWithICS(event, emit);
        if (event is AbsenceListLoadSingelageEvent) return absenceListLoadSingelPage(event, emit);
      },
    );
  }

  Future<void> absenceListFetch(AbsenceListFetchEvent event, Emitter<AbsenceState> emit) async {
    emit(AbsenceLoadingState());
    _currentPageIndex = 1;
    Either<Failure, AbsencesList> result = await fetchAbsenceListApiUsecase.call();
    return result.fold(
      (Failure failureResult) {
        emit(AbsenceFailurState(errorMessage: failureResult.message));
      },
      (AbsencesList absencesListResult) async {
        if (absencesListResult.payload.isNotEmpty) {
          await fetchMemberUsecase(absencesListResult);
          _absencesList = absencesListResult;
          showingAbsenceList = List.from(_absencesList!.payload);

          List<Absence> absenceListWithPagination = pagination();
          emit(AbsenceloadedState(absenceList: absenceListWithPagination, totalAbcenceCount: showingAbsenceList.length));
        } else {
          emit(AbsenceloadedState(absenceList: [], totalAbcenceCount: 0));
        }
      },
    );
  }

  Future<void> absenceListLoadmore(AbsenceListLoadmoreEvent event, Emitter<AbsenceState> emit) async {
    _currentPageIndex++;
    List<Absence> absenceListWithPagination = pagination();
    emit(AbsenceloadedState(absenceList: absenceListWithPagination, totalAbcenceCount: showingAbsenceList.length));
  }

  Future<void> absenceFilter(AbsenceFilterEvent event, Emitter<AbsenceState> emit) async {
    emit(AbsenceLoadingState());
    _currentPageIndex = 1;
    chosenFilter = event.selectedFilter;
    showingAbsenceList = List.from(_absencesList?.payload ?? []);
    emit(AbsenceUpdateFiltersListState());

    if (event.selectedFilter.absenceType == AbsentType.sickness) {
      showingAbsenceList.removeWhere((absence) => absence.type != AbsentType.sickness);
    } else if (event.selectedFilter.absenceType == AbsentType.vacation) {
      showingAbsenceList.removeWhere((absence) => absence.type != AbsentType.vacation);
    }

    if (event.selectedFilter.startDate != null && event.selectedFilter.endDate != null) {
      showingAbsenceList.removeWhere(
        (absence) => (absence.startDate.isBefore(event.selectedFilter.startDate!) || absence.endDate.isAfter(event.selectedFilter.endDate!)),
      );
    }
    List<Absence> absenceListWithPagination = pagination();
    emit(AbsenceloadedState(absenceList: absenceListWithPagination, totalAbcenceCount: showingAbsenceList.length));
  }

  Future<void> absenceSendEmailWithICS(AbsenceListSentEmailWithICSEvent event, Emitter<AbsenceState> emit) async {
    Uint8List uint8list = icsByteFileBuilder(event.absence);

    Either<Failure, bool> result = await sendEmailWithICSUsecase.call(uint8list, event.email);
    return result.fold(
      (Failure emailFailure) {
        emit(AbsenceEmailSentStatusState(absence: event.absence, status: false));
      },
      (bool result) {
        emit(AbsenceEmailSentStatusState(absence: event.absence, status: true));
      },
    );
  }

  Future<void> absenceListLoadSingelPage(AbsenceListLoadSingelageEvent event, Emitter<AbsenceState> emit) async {
    _currentPageIndex = event.page;
    List<Absence> absenceListWithPagination = pagination();
    emit(AbsenceloadedState(absenceList: absenceListWithPagination, totalAbcenceCount: showingAbsenceList.length));
  }
  ///////////////////////////////////////////////////////////
  // Functions

  Future<bool> fetchMemberUsecase(AbsencesList absencesListInput) async {
    Either<Failure, MembersList> result = await fetchMemberListApiUsecase.call();
    result.fold(
      (Failure failureResult) {
        return false;
      },
      (MembersList memberListResult) {
        assignMemberToAbsence(absencesListInput, memberListResult);
        return true;
      },
    );
    return false;
  }

  void assignMemberToAbsence(AbsencesList absencesListInput, MembersList memberListResult) {
    for (Absence absencElement in absencesListInput.payload) {
      for (Member memberElement in memberListResult.payload) {
        if (absencElement.userId == memberElement.userId) {
          absencElement.memberInfo = memberElement;
          break;
        }
      }
    }
  }

  List<Absence> pagination() {
    if (_isSinglePageApproch) {
      return showingAbsenceList.sublist(
        (_currentPageIndex == 1) ? 0 : (_currentPageIndex - 1) * 10,
        (_currentPageIndex * 10) > showingAbsenceList.length ? showingAbsenceList.length : (_currentPageIndex * 10),
      );
    } else {
      return showingAbsenceList.sublist(0, (_currentPageIndex * 10) > showingAbsenceList.length ? showingAbsenceList.length : (_currentPageIndex * 10));
    }
  }

  bool enableLoadmore(int listLength) {
    if (listLength >= _currentPageIndex * 10) {
      return true;
    } else {
      return false;
    }
  }

  Uint8List icsByteFileBuilder(Absence absence) {
    final icsContent = '''
BEGIN:VCALENDAR
VERSION:2.0
CALSCALE:GREGORIAN
BEGIN:VEVENT
UID:${absence.id}
DTSTAMP:${_formatDateTime(DateTime.now())}
DTSTART:${_formatDateTime(absence.startDate)}
DTEND:${_formatDateTime(absence.endDate)}
SUMMARY:Absence - ${absence.memberInfo?.name ?? "User not exist"} - ${absence.type.name} 
DESCRIPTION:${absence.admitterNote}
STATUS:CONFIRMED
END:VEVENT
END:VCALENDAR
  ''';
    return Uint8List.fromList(icsContent.codeUnits);
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').split('.')[0]}Z';
  }

  @visibleForTesting
  set testAbsencesList(AbsencesList absencesList) {
    _absencesList = absencesList;
  }
}
