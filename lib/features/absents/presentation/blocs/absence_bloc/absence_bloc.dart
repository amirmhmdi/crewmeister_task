import 'package:bloc/bloc.dart';
import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absence.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absences_list.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';
import 'package:crewmeister_task/features/absents/domain/entities/filter.dart';
import 'package:crewmeister_task/features/absents/domain/entities/member.dart';
import 'package:crewmeister_task/features/absents/domain/entities/members_list.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/fetch_absence_list_api_usecase.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/fetch_member_list_api_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'absence_event.dart';
part 'absence_state.dart';

class AbsenceBloc extends Bloc<AbsenceEvent, AbsenceState> {
  final FetchAbsenceListApiUsecase fetchAbsenceListApiUsecase;
  final FetchMemberListApiUsecase fetchMemberListApiUsecase;
  AbsencesList? _absencesList;
  int page = 1;
  List<Absence> showingAbsenceList = [];
  FilterAbsence chosenFilter = FilterAbsence(absenceType: AbsentType.all, startDate: null, endDate: null);

  AbsenceBloc({
    required this.fetchAbsenceListApiUsecase,
    required this.fetchMemberListApiUsecase,
  }) : super(AbsenceLoadingState()) {
    on<AbsenceEvent>(
      (AbsenceEvent event, Emitter<AbsenceState> emit) async {
        if (event is AbsenceListFetchEvent) return absenceListFetch(event, emit);
        if (event is AbsenceListLoadmoreEvent) return absenceListLoadmore(event, emit);
        if (event is AbsenceFilterEvent) return absenceFilter(event, emit);
      },
    );
  }

  Future<void> absenceListFetch(AbsenceListFetchEvent event, Emitter<AbsenceState> emit) async {
    emit(AbsenceLoadingState());
    page = 1;
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
    page++;
    List<Absence> absenceListWithPagination = pagination();
    emit(AbsenceloadedState(absenceList: absenceListWithPagination, totalAbcenceCount: showingAbsenceList.length));
  }

  Future<void> absenceFilter(AbsenceFilterEvent event, Emitter<AbsenceState> emit) async {
    emit(AbsenceLoadingState());
    page = 1;
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
    return showingAbsenceList.sublist(0, (page * 10) > showingAbsenceList.length ? showingAbsenceList.length : (page * 10));
  }

  bool enableLoadmore(int listLength) {
    if (listLength >= page * 10) {
      return true;
    } else {
      return false;
    }
  }

  @visibleForTesting
  set testAbsencesList(AbsencesList absencesList) {
    _absencesList = absencesList;
  }
}
