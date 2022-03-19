import 'package:simple_crud/data/models/user/user_model.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../fixtures/user_fixture.dart';

void main() {
  group("UserModel >", () {
    test("Should parse FROM JSON correctly", () {
      final result = UserModel.fromJson(UserFixture.json);
      expect(result.uid, "uid");
      expect(result.name, "name");
      expect(result.email, "email");
      expect(result.createdAt.day, 17);
      expect(result.updatedAt?.day, 18);
    });

    test("Should parse TO JSON correctly", () {
      final result = UserFixture.model.toJson();
      expect(result["uid"], "uid");
      expect(result["name"], "name");
      expect(result["email"], "email");
      expect(result["createdAt"], isNotNull);
      expect(result["updatedAt"], isNotNull);
    });

    test("Should create a User Object from simple infos", () {
      final result = UserModel.simple(name: "name", email: "email");
      expect(result.uid, isNotNull);
      expect(result.createdAt, isNotNull);
      expect(result.name, "name");
      expect(result.email, "email");
    });
  });

  group("UserCollection >", () {
    test("Should parse FROM JSON correctly", () {
      final sut = UserCollection.fromJson(UserCollectionFixture.json);
      expect(sut.users.length, 1);
      expect(sut.users.first.uid, "uid");
    });

    test("Should parse TO JSON correctly", () {
      final sut = UserCollectionFixture.model.toJson();
      expect(sut["users"], isNotNull);
      expect(sut["users"][0]["uid"], "uid");
    });
  });
}
