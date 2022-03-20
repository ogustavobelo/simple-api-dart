import 'package:mocktail/mocktail.dart';
import 'package:shelf/shelf.dart';
import 'package:simple_crud/controllers/users/users_routes.dart';
import 'package:simple_crud/data/models/mappers/user_serialize_mapper.dart';
import 'package:simple_crud/data/models/user/user_model.dart';
import 'package:simple_crud/domain/usecases/list_users_usecase.dart';
import 'package:simple_crud/domain/usecases/save_user_usecase.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../core/dependency_injection/dependency_injection.test.dart';

class MockListUserUseCase extends Mock implements ListUserUseCase {}

class MockSaveUserUseCase extends Mock implements SaveUserUseCase {}

void main() {
  dependenciesTestSetup();
  group("UserController >", () {
    final listUserMock = MockListUserUseCase();
    final saveUserMock = MockSaveUserUseCase();
    final sut = UsersPrivateController(
      listUserUseCase: listUserMock,
      saveUserUseCase: saveUserMock,
    );

    group("List User >", () {
      final request = Request(
        "get",
        Uri(scheme: "scheme", path: "/users"),
        headers: {"authorization": "Bearer auth"},
      );
      test("When success should return a 200 status code", () async {
        when(() => listUserMock.call())
            .thenAnswer((_) async => UserCollection([]).serialize());

        final result = await sut.listUsers(request);

        expect(result.statusCode, 200);
      });

      test("When fails should return a 400 status code", () async {
        when(() => listUserMock.call()).thenThrow(Exception());

        final result = await sut.listUsers(request);

        expect(result.statusCode, 400);
      });
    });
  });
}
