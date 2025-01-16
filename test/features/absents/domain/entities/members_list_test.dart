import 'package:crewmeister_task/features/absents/domain/entities/member.dart';
import 'package:crewmeister_task/features/absents/domain/entities/members_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MembersList', () {
    final member = Member(
      crewId: 1,
      id: 101,
      image: 'https://example.com/image.png',
      name: 'John Doe',
      userId: 202,
    );

    test('should create a MembersList instance correctly', () {
      // Arrange
      final membersList = MembersList(
        message: 'Success',
        payload: [member],
      );

      // Assert
      expect(membersList.message, 'Success');
      expect(membersList.payload, [member]);
    });

    test('should support equality comparison', () {
      // Arrange
      final membersList1 = MembersList(
        message: 'Success',
        payload: [member],
      );

      final membersList2 = MembersList(
        message: 'Success',
        payload: [member],
      );

      final membersList3 = MembersList(
        message: 'Failed',
        payload: [member],
      );

      // Assert
      expect(membersList1, equals(membersList2));
      expect(membersList1, isNot(equals(membersList3)));
    });

    test('should return correct props for Equatable', () {
      // Arrange
      final membersList = MembersList(
        message: 'Success',
        payload: [member],
      );

      // Assert
      expect(membersList.props, ['Success', [member]]);
    });
  });
}
