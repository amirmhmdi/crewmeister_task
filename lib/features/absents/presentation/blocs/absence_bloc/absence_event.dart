part of 'absence_bloc.dart';

sealed class AbsenceEvent extends Equatable {
  const AbsenceEvent();

  @override
  List<Object> get props => [];
}

final class AbsenceListFetchEvent extends AbsenceEvent {}

final class AbsenceListLoadmoreEvent extends AbsenceEvent {}

final class AbsenceListSentEmailWithICSEvent extends AbsenceEvent {
  final Absence absence;
  final String email;

  const AbsenceListSentEmailWithICSEvent({required this.absence, required this.email});
  @override
  List<Object> get props => [];
}

final class AbsenceFilterEvent extends AbsenceEvent {
  final FilterAbsence selectedFilter;

  const AbsenceFilterEvent({
    required this.selectedFilter,
  });

  @override
  List<Object> get props => [];
}

final class AbsenceListLoadSingelageEvent extends AbsenceEvent {
  final int page;

  const AbsenceListLoadSingelageEvent({required this.page});

  @override
  List<Object> get props => [page];
}
