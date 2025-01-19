part of 'absence_bloc.dart';

sealed class AbsenceState extends Equatable {
  const AbsenceState();

  @override
  List<Object> get props => [];
}

final class AbsenceLoadingState extends AbsenceState {}

final class AbsenceloadedState extends AbsenceState {
  final List<Absence> absenceList;
  final int totalAbcenceCount;

  const AbsenceloadedState({
    required this.absenceList,
    required this.totalAbcenceCount,
  });

  @override
  List<Object> get props => [absenceList];
}

final class AbsenceFailurState extends AbsenceState {
  final String errorMessage;

  const AbsenceFailurState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class AbsenceUpdateFiltersListState extends AbsenceState {
  const AbsenceUpdateFiltersListState();

  @override
  List<Object> get props => [];
}
