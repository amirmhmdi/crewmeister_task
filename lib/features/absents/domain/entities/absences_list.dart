import 'package:crewmeister_task/features/absents/domain/entities/absence.dart';
import 'package:equatable/equatable.dart';

class AbsencesList extends Equatable {
  final String message;
  final Absence payload;

  const AbsencesList({
    required this.message,
    required this.payload,
  });

  @override
  List<Object?> get props => [message, payload];
}
