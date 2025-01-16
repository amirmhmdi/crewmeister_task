import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/domain/entities/absences_list.dart';
import 'package:crewmeister_task/features/absents/domain/repositories/absence_repository.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/fetch_absence_list_api_usecase.dart';

class MockAbsenceRepository extends Mock implements AbsenceRepository {}

void main() {
  late FetchAbsenceListApiUsecase usecase;
  late MockAbsenceRepository mockAbsenceRepository;

  setUp(() {
    mockAbsenceRepository = MockAbsenceRepository();
    usecase = FetchAbsenceListApiUsecase(absenceRepository: mockAbsenceRepository);
  });

  const testAbsencesList = AbsencesList(
    message: 'Success',
    payload: [],
  );

  test('should return AbsencesList from the repository when successful', () async {
    when(() => mockAbsenceRepository.fetchAbsencesListApi()).thenAnswer((_) async => const Right(testAbsencesList));

    final result = await usecase();

    expect(result, const Right(testAbsencesList));
    verify(() => mockAbsenceRepository.fetchAbsencesListApi()).called(1);
    verifyNoMoreInteractions(mockAbsenceRepository);
  });

  test('should return Failure when the repository fails', () async {
    const testFailure = ServerFailure('Server Failure');
    when(() => mockAbsenceRepository.fetchAbsencesListApi()).thenAnswer((_) async => const Left(testFailure));

    final result = await usecase();

    expect(result, const Left(testFailure));
    verify(() => mockAbsenceRepository.fetchAbsencesListApi()).called(1);
    verifyNoMoreInteractions(mockAbsenceRepository);
  });
}
