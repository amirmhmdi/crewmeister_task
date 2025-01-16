import 'package:crewmeister_task/core/error/failure.dart';
import 'package:crewmeister_task/features/absents/data/datasources/absence_datasource.dart';
import 'package:crewmeister_task/features/absents/data/repositories/absence_repository_impl.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

const String absenceListJson = '''
{
  "message": "Success",
  "payload": [
    {
      "admitterId": null,
      "admitterNote": "",
      "confirmedAt": "2020-12-12T18:03:55.000+01:00",
      "createdAt": "2020-12-12T14:17:01.000+01:00",
      "crewId": 352,
      "endDate": "2021-01-13",
      "id": 2351,
      "memberNote": "",
      "rejectedAt": null,
      "startDate": "2021-01-13",
      "type": "sickness",
      "userId": 2664
    },
    {
      "admitterId": null,
      "admitterNote": "Sorry",
      "confirmedAt": null,
      "createdAt": "2021-01-03T17:36:52.000+01:00",
      "crewId": 352,
      "endDate": "2021-01-05",
      "id": 2521,
      "memberNote": "ganzer tag",
      "rejectedAt": "2021-01-03T17:39:50.000+01:00",
      "startDate": "2021-01-05",
      "type": "vacation",
      "userId": 2664
    }
  ]
}
''';

class MockAbsenceDatasource extends Mock implements AbsenceDatasource {}

void main() {
  late AbsenceRepositoryImpl repository;
  late MockAbsenceDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockAbsenceDatasource();
    repository = AbsenceRepositoryImpl(absenceDatasource: mockDatasource);

    // Register the mock http.Response as a stub return type
    registerFallbackValue(http.Response('', 200));
  });

  group('fetchAbsencesListApi', () {
    test('should return AbsencesList when the call is successful', () async {
      // Arrange
      final response = http.Response(absenceListJson, 200);
      when(() => mockDatasource.fetchAbsenceListApi()).thenAnswer((_) async => response);

      // Act
      final result = await repository.fetchAbsencesListApi();

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected a successful result'),
        (absencesList) {
          expect(absencesList.message, 'Success');
          expect(absencesList.payload.length, 2);
          expect(absencesList.payload[0].type, AbsentType.sickness);
          expect(absencesList.payload[1].type, AbsentType.vacation);
        },
      );
      verify(() => mockDatasource.fetchAbsenceListApi()).called(1);
    });

    test('should return ServerFailure when the response code is not 200', () async {
      // Arrange
      final response = http.Response('Something went wrong', 500);
      when(() => mockDatasource.fetchAbsenceListApi()).thenAnswer((_) async => response);

      // Act
      final result = await repository.fetchAbsencesListApi();

      // Assert
      expect(result, Left(ServerFailure('Server Failure')));
      verify(() => mockDatasource.fetchAbsenceListApi()).called(1);
    });

    test('should return ServerFailure on exception', () async {
      // Arrange
      when(() => mockDatasource.fetchAbsenceListApi()).thenThrow(Exception('Failed to fetch'));

      // Act
      final result = await repository.fetchAbsencesListApi();

      // Assert
      expect(result, Left(ServerFailure('Somethings were wrong')));
      verify(() => mockDatasource.fetchAbsenceListApi()).called(1);
    });
  });
}
