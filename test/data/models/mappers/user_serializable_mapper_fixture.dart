import 'package:simple_crud/data/models/mappers/user_serialize_mapper.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../fixtures/serialized_user_fixture.dart';
import '../../../fixtures/user_fixture.dart';

void main() {
  group("UserSerializable Mapper >", () {
    test("Should parse a User to Serializable", () {
      final user = UserFixture.model;
      final serialized = user.serialize();
      expect(serialized.json, isNotNull);
      expect(serialized.json["uid"], isNotNull);
    });

    test("Should parse a Serializable to User", () {
      final serialized = SerializedUserFixture.user;
      final user = serialized.deserializeUser();
      expect(user.uid, "uid");
    });
  });
}
