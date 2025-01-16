import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/domain/entities/members_list.dart';
import 'package:crewmeister_task/features/absents/domain/repositories/absence_repository.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/fetch_member_list_api_usecase.dart';

class MockAbsenceRepository extends Mock implements AbsenceRepository {}

void main() {
  late FetchMemberListApiUsecase usecase;
  late MockAbsenceRepository mockAbsenceRepository;

  setUp(() {
    mockAbsenceRepository = MockAbsenceRepository();
    usecase = FetchMemberListApiUsecase(absenceRepository: mockAbsenceRepository);
  });

  const testMembersList = MembersList(
    message: 'Success',
    payload: [],
  );

  test('should return MembersList from the repository when successful', () async {
    when(() => mockAbsenceRepository.fetchMemberListApi()).thenAnswer((_) async => const Right(testMembersList));

    final result = await usecase();

    expect(result, const Right(testMembersList));
    verify(() => mockAbsenceRepository.fetchMemberListApi()).called(1);
    verifyNoMoreInteractions(mockAbsenceRepository);
  });

  test('should return Failure when the repository fails', () async {
    const testFailure = ServerFailure('Server Failure');
    when(() => mockAbsenceRepository.fetchMemberListApi()).thenAnswer((_) async => const Left(testFailure));

    final result = await usecase();

    expect(result, const Left(testFailure));
    verify(() => mockAbsenceRepository.fetchMemberListApi()).called(1);
    verifyNoMoreInteractions(mockAbsenceRepository);
  });
}
