import 'package:mocktail/mocktail.dart';
import 'package:simple_crud/core/exceptions/local_datasource_exceptions.dart';
import 'package:simple_crud/data/datasources/local/database/acess_database.dart';
import 'package:simple_crud/data/datasources/local/database/collections.dart';
import 'package:simple_crud/data/datasources/local/users/users_local_datasource.dart';
import 'package:simple_crud/data/models/user/user_model.dart';
import 'package:test/test.dart';

class MockAccessDatabase extends Mock implements AccessDatabase {}

void main() {
  group("UsersLocalDataSource >", () {
    final database = MockAccessDatabase();
    final sut = UsersLocalDataSourceImpl(database: database);

    group("List Users >", () {
      test("When get successfully, should return an User Collection", () async {
        when(() => database.listAll(Collections.users)).thenAnswer((_) async => []);
        final result = await sut.listUsers();
        expect(result, isA<UserCollection>());
        expect(result.users.length, 0);
      });
      test("When fails, should throw an LocalDataSourceException", () async {
        when(() => database.listAll(Collections.users)).thenThrow(Exception());
        try {
          final result = await sut.listUsers();
          expect(result, isNull);
        } catch (exception) {
          expect(exception, isA<LocalDataSourceException>());
        }
      });
    });
  });
}
