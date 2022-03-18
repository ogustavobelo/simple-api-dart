import 'package:mocktail/mocktail.dart';
import 'package:simple_crud/data/datasources/local/users/users_local_datasource.dart';
import 'package:simple_crud/data/models/user/user_model.dart';
import 'package:simple_crud/data/repositories/user_repository_impl.dart';
import 'package:simple_crud/domain/entities/serializable/serializable.dart';
import 'package:test/test.dart';

class MockUsersLocalDataSource extends Mock implements UsersLocalDataSource {}

void main() {
  group("UserRepository >", () {
    final localDataSource = MockUsersLocalDataSource();
    final sut = UserRepositoryImpl(localDataSource: localDataSource);

    test("Should return an user list", () async {
      when(() => localDataSource.listUsers()).thenAnswer((_) async => UserCollection([]));
      final result = await sut.listAllUsers();
      expect(result, isA<Serializable>());
    });
  });
}
