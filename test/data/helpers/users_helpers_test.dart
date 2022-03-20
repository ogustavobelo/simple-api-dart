import 'package:mocktail/mocktail.dart';
import 'package:simple_crud/core/enviroment.dart';
import 'package:simple_crud/data/helpers/users_helper.dart';
import 'package:test/test.dart';

import '../../core/dependency_injection/dependency_injection.test.dart';

void main() {
  dependenciesTestSetup();
  group("Users Helpers >", () {
    final sut = UsersHelperImpl();

    setUp((){
      when(()=> getIt<Environment>().jwtKey).thenReturn("key");
      when(()=> getIt<Environment>().jwtIssure).thenReturn("issure");
    });
    test("Should create a User Object from simple infos", () {
      final result = sut.buildUser("name", "email");
      expect(result.uid, isNotNull);
      expect(result.createdAt, isNotNull);
      expect(result.name, "name");
      expect(result.email, "email");
    });
  });
}
