import 'package:mocktail/mocktail.dart';
import 'package:simple_crud/data/datasources/local/users/users_local_datasource.dart';
import 'package:simple_crud/data/models/user/user_model.dart';
import 'package:simple_crud/data/repositories/user_repository_impl.dart';
import 'package:simple_crud/domain/entities/serializable/serializable.dart';
import 'package:test/test.dart';

import '../../fixtures/user_fixture.dart';
import '../../mocks/user_mocks.dart';

void main() {
  group("UserRepository >", () {
    final localDataSource = MockUsersLocalDataSource();
    final helper = MockUsersHelper();
    final sut = UserRepositoryImpl(
      localDataSource: localDataSource,
      helper: helper,
    );

    test("Should return an user list", () async {
      when(() => localDataSource.listUsers())
          .thenAnswer((_) async => UserCollection([]));
      final result = await sut.listAllUsers();
      expect(result, isA<Serializable>());
    });

    test("Should save an user in local database", () async {
      final user = UserFixture.model;
      when(() => helper.buildUser(user.name, user.email)).thenReturn(user);
      when(() => localDataSource.saveUser(user)).thenAnswer((_) async => user);
      final result = await sut.saveUser(user.name, user.email);
      expect(result, isA<Serializable>());
      expect(result.json["email"], user.email);
    });
  });
}
