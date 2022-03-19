import 'package:mocktail/mocktail.dart';
import 'package:simple_crud/domain/usecases/save_user_usecase.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../fixtures/serialized_user_fixture.dart';
import '../../fixtures/user_fixture.dart';
import '../../mocks/user_mocks.dart';

void main() {
  group("List Users UseCase >", () {
    final repository = MockUserRepository();
    final sut = SaveUserUseCase(repository: repository);
    final user = UserFixture.model;
    final serialUser = SerializedUserFixture.user;

    test("When success, should return a Serialized user", () async {
      when(() => repository.saveUser(user.name, user.email))
          .thenAnswer((_) async => serialUser);
      final result = await sut.call(user.name, user.email);
      expect(result.json, isNotNull);
      expect(result.json["email"], user.email);
    });

    test("When fails, should rethrow exception", () async {
      when(() => repository.saveUser(user.name, user.email))
          .thenThrow(Exception());
      try {
        final result = await sut.call(user.name, user.email);
        expect(result.json, isNull);
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
}
