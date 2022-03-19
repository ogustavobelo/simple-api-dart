import 'package:mocktail/mocktail.dart';
import 'package:simple_crud/domain/usecases/list_users_usecase.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../fixtures/serialized_user_fixture.dart';
import '../../mocks/user_mocks.dart';

void main() {
  group("Save User UseCase >", () {
    final repository = MockUserRepository();
    final sut = ListUserUseCase(repository: repository);

    test("When success, should return a Serialized list", () async {
      when(() => repository.listAllUsers())
          .thenAnswer((_) async => SerializedUserFixture.userCollection);
      final result = await sut.call();
      expect(result.json, isNotNull);
    });

    test("When fails, should rethrow exception", () async {
      when(() => repository.listAllUsers()).thenThrow(Exception());
      try {
        final result = await sut.call();
        expect(result.json, isNull);
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
}
