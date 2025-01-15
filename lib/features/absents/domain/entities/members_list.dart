import 'package:crewmeister_task/features/absents/domain/entities/member.dart';
import 'package:equatable/equatable.dart';

class MembersList extends Equatable {
  final String message;
  final Member payload;

  const MembersList({
    required this.message,
    required this.payload,
  });

  @override
  List<Object?> get props => [message, payload];
}
