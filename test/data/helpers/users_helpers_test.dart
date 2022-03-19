import 'package:simple_crud/data/helpers/users_helper.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

void main() {
  group("Users Helpers >", () {
    final sut = UsersHelperImpl();
    test("Should create a User Object from simple infos", () {
      final result = sut.buildUser("name", "email");
      expect(result.uid, isNotNull);
      expect(result.createdAt, isNotNull);
      expect(result.name, "name");
      expect(result.email, "email");
    });
  });
}
