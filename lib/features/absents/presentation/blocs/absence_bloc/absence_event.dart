part of 'absence_bloc.dart';

sealed class AbsenceEvent extends Equatable {
  const AbsenceEvent();

  @override
  List<Object> get props => [];
}

final class AbsenceListFetchEvent extends AbsenceEvent {}

final class AbsenceListLoadmoreEvent extends AbsenceEvent {}

final class AbsenceFilterEvent extends AbsenceEvent {
  final FilterAbsence selectedFilter;

  const AbsenceFilterEvent({
    required this.selectedFilter,
  });

  @override
  List<Object> get props => [];
}
