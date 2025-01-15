import 'package:crewmeister_task/features/absents/data/models/member_model.dart';
import 'package:crewmeister_task/features/absents/data/models/members_list_model.dart';
import 'package:crewmeister_task/features/absents/domain/entities/members_list.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../res/member_json.dart';

void main() {
  group('MembersListModel', () {
    final membersListJson = {
      'message': 'Success',
      'payload': memberModeljson,
    };

    final memberModel = MemberModel(
      crewId: 1,
      id: 101,
      image: 'https://example.com/image.jpg',
      name: 'John Doe',
      userId: 202,
    );

    final membersListModel = MembersListModel(
      message: 'Success',
      payload: memberModel,
    );

    test('should correctly deserialize from JSON', () {
      final result = MembersListModel.fromJson(membersListJson);

      expect(result.message, 'Success');
      expect(result.payload.crewId, 1);
      expect(result.payload.name, 'John Doe');
    });

    test('should correctly serialize to JSON', () {
      final jsonResult = membersListModel.toJson();

      expect(jsonResult, membersListJson);
    });

    test('should correctly convert to domain model', () {
      final domainResult = membersListModel.toDomin();

      expect(domainResult, isA<MembersList>());
      expect(domainResult.message, 'Success');
      expect(domainResult.payload.id, 101);
      expect(domainResult.payload.name, 'John Doe');
    });
  });
}
