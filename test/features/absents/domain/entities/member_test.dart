import 'package:crewmeister_task/features/absents/domain/entities/member.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Member', () {
    test('should create a Member instance correctly', () {
      // Arrange
      final member = Member(
        crewId: 1,
        id: 101,
        image: 'https://example.com/image.png',
        name: 'John Doe',
        userId: 202,
      );

      // Assert
      expect(member.crewId, 1);
      expect(member.id, 101);
      expect(member.image, 'https://example.com/image.png');
      expect(member.name, 'John Doe');
      expect(member.userId, 202);
    });

    test('should support equality comparison', () {
      // Arrange
      final member1 = Member(
        crewId: 1,
        id: 101,
        image: 'https://example.com/image.png',
        name: 'John Doe',
        userId: 202,
      );

      final member2 = Member(
        crewId: 1,
        id: 101,
        image: 'https://example.com/image.png',
        name: 'John Doe',
        userId: 202,
      );

      final member3 = Member(
        crewId: 2,
        id: 102,
        image: 'https://example.com/image2.png',
        name: 'Jane Smith',
        userId: 203,
      );

      // Assert
      expect(member1, equals(member2)); 
      expect(member1, isNot(equals(member3))); 
    });
  });
}
