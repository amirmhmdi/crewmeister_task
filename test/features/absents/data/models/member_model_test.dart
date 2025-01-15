import 'package:crewmeister_task/features/absents/data/models/member_model.dart';
import 'package:crewmeister_task/features/absents/domain/entities/member.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../res/member_json.dart';

void main() {
  group('MemberModel', () {
    final memberModel = MemberModel(
      crewId: 1,
      id: 101,
      image: 'https://example.com/image.jpg',
      name: 'John Doe',
      userId: 202,
    );

    test('should correctly deserialize from JSON', () {
      final result = MemberModel.fromJson(memberModeljson);

      expect(result.crewId, 1);
      expect(result.id, 101);
      expect(result.image, 'https://example.com/image.jpg');
      expect(result.name, 'John Doe');
      expect(result.userId, 202);
    });

    test('should correctly serialize to JSON', () {
      final jsonResult = memberModel.toJson();

      expect(jsonResult, memberModeljson);
    });

    test('should correctly convert to domain model', () {
      final domainResult = memberModel.toDomain();

      expect(domainResult, isA<Member>());
      expect(domainResult.crewId, 1);
      expect(domainResult.id, 101);
      expect(domainResult.image, 'https://example.com/image.jpg');
      expect(domainResult.name, 'John Doe');
      expect(domainResult.userId, 202);
    });
  });
}
